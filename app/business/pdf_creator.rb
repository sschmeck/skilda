require 'pdfkit'

module PdfCreator

  def create_person(person)
    html = erb :'pdf/skill_profile', locals: { person: person }

    PDFKit.new(html).to_pdf
  end

end
