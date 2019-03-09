INPUT_PATH  = '/pdf/input_pdf'
OUTPUT_PATH = '/pdf/output_pdf'

pdf_files = Dir.glob(File.join(INPUT_PATH, '*.pdf'))
pdf_files.each do |input_pdf|
  output_pdf = File.join(OUTPUT_PATH, File.basename(input_pdf))
  system "pdftk #{input_pdf} cat 3-r2 output #{output_pdf}"
end
