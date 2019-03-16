require 'fileutils'
require 'shellwords'
require 'optparse'

INPUT_PATH  = '/pdf/input'
OUTPUT_PATH = '/pdf/output'

# parse ARGV
opt = OptionParser.new
opt.on('-s')
begin
  split_list = opt.parse(ARGV)
  
  process_list =
    split_list.map do |sp|
      color, page = sp.split(':')
      raise OptionParser::InvalidOption unless color == 'g' || color == 'c'
      raise OptionParser::InvalidOption if page.nil?
      { color: color, page: page }
    end
rescue OptionParser::InvalidOption
  puts 'Invalid arguments'
end

pdf_files = Dir.glob(File.join(INPUT_PATH, '*.pdf'))
pdf_files.each do |pdf_file|
  input_pdf = Shellwords.escape(pdf_file)
  output_pdf = File.join(OUTPUT_PATH, File.basename(input_pdf))
  process_list.each.with_index do |process, idx|
    system "pdftk #{input_pdf} cat #{process[:page]} output /tmp/#{idx}.pdf"

    if process[:color] == 'g'
      # convert grayscale pdf
      grayscale_command =  "gs -sOutputFile=/tmp/g#{idx}.pdf "
      grayscale_command += '-sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.4 -dAutoRotatePages=/None -dNOPAUSE '
      grayscale_command += "-dBATCH /tmp/#{idx}.pdf"
      system grayscale_command

      # remove color pdf
      FileUtils.rm(Dir.glob("/tmp/#{idx}.pdf"))
    end
  end

  # merge pdf
  merge_command = 'pdftk '
  merge_command +=
    process_list.map.with_index do |process, idx|
      if process[:color] == 'g'
        "/tmp/g#{idx}.pdf "
      else
        "/tmp/#{idx}.pdf "
      end
    end.join
  merge_command += "cat output #{output_pdf}"

  system merge_command

  FileUtils.rm(Dir.glob('/tmp/*.pdf'))
end
