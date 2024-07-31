require 'prawn'

Prawn::Document.generate('spec/fixtures/sample_document.pdf') do
  text 'This is a sample document for testing purposes.'
end
