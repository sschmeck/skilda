require 'pdfkit'


# PDFKit uses the tool 'wkhtmltopdf'. This tool needs to be installed on the server.
# for ubuntu-like linux: 'sudo apt-get install wkhtmltopdf'

module PdfCreator
  def create_person(person)
    html = erb :"pdf/skill_profile", :locals => {:person => person}

    kit = PDFKit.new(html)

    kit.to_pdf
  end
end