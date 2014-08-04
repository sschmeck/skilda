require 'pdfkit'


# PDFKit uses the tool 'wkhtmltopdf'. This tool needs to be installed on the server.
# for ubuntu-like linux: 'sudo apt-get install wkhtmltopdf'

module PdfCreator

  TEMPLATE = File.join(File.dirname(__FILE__), '/../views/pdf/skill_profile.erb')

  def create_skill_profile_pdf(person)
    html = ERB.new(File.read(TEMPLATE)).result(binding)
    kit = PDFKit.new(html)
    kit.to_pdf
  end
end