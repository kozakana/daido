INPUT_PATH  = '/pdf/input_pdf'
OUTPUT_PATH = '/pdf/output_pdf'

pdf_files = Dir.glob(File.join(INPUT_PATH, '*.pdf'))
pdf_files.each do |input_pdf|
  output_pdf = File.join(OUTPUT_PATH, File.basename(input_pdf))
  system "pdftk #{input_pdf} cat 1 output /tmp/0.pdf"
  system "pdftk #{input_pdf} cat 2-r2 output /tmp/1.pdf"
  system "pdftk #{input_pdf} cat r1 output /tmp/2.pdf"

  grayscale_command =  "gs -sOutputFile=/tmp/grayscale.pdf "
  grayscale_command += '-sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.4 -dAutoRotatePages=/None '
  grayscale_command += '-dBATCH /tmp/1.pdf'

  system grayscale_command

  system "pdftk /tmp/0.pdf /tmp/grayscale.pdf /tmp/1.pdf cat output #{output_pdf}"
end
