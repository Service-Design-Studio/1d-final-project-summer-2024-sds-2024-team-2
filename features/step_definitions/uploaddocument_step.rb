Given(/^I am an undocumented individual$/) do
  @user = User.create!(
    username: 'undocumented_user',
    email: 'undocumented@example.com',
    phone_number: '1234567890',
    password: 'password', # Set the password attribute
    registered: false,
    needs_document_upload: true
  )
end

Given(/^I have completed the initial registration process$/) do
  @user.update(registered: true)
end

Given(/^I need to upload my documents to complete my digital identity$/) do
  @user.update(needs_document_upload: true)
end

When(/^I drag a document file into the designated drop area$/) do
  attach_file('document_upload', Rails.root.join('spec/fixtures/sample_document.pdf'))
end

Then(/^I should see the file name, file size, and date of upload$/) do
  expect(page).to have_content('sample_document.pdf')
  expect(page).to have_content('Size: 123 KB') # Adjust size according to your file
  expect(page).to have_content(Date.today.strftime('%Y-%m-%d'))
end

Then(/^a new field should appear to describe the document added$/) do
  expect(page).to have_selector('input[name="document_description"]')
end

Then(/^a dropdown menu to select the type of document I am uploading should be displayed above the designated drop area$/) do
  expect(page).to have_selector('select[name="document_type"]')
end

Then(/^I should have an option to view and remove the document$/) do
  expect(page).to have_button('View')
  expect(page).to have_button('Remove')
end

When(/^I select a file with an unsupported format$/) do
  attach_file('document_upload', Rails.root.join('spec/fixtures/unsupported_file.xyz'))
end

When(/^I select a file that exceeds the size limit$/) do
  attach_file('document_upload', Rails.root.join('spec/fixtures/large_file.zip'))
end

Then(/^I should see an error message stating "Unsupported file type. Please upload a PDF, DOCX, or JPG file."$/) do
  expect(page).to have_content('Unsupported file type. Please upload a PDF, DOCX, or JPG file.')
end

Then(/^I should see an error message stating "File size exceeds the maximum limit of 5MB. Please upload a smaller file."$/) do
  expect(page).to have_content('File size exceeds the maximum limit of 5MB. Please upload a smaller file.')
end

Given(/^I have uploaded a document$/) do
  attach_file('document_upload', Rails.root.join('spec/fixtures/sample_document.pdf'))
  click_button('Upload')
end

When(/^I click on the "([^"]*)" button next to the uploaded document$/) do |button|
  within('.uploaded-document') do
    click_button(button)
  end
end

Then(/^I should be able to preview the document$/) do
  expect(page).to have_selector('.document-preview')
end

When(/^I select an option from the dropdown menu to categorize the document$/) do
  select('ID Card', from: 'document_type')
end

Then(/^the document should be categorized correctly$/) do
  expect(page).to have_select('document_type', selected: 'ID Card')
end

When(/^I look at the top of the page$/) do
  # No action needed, just checking the content
end

Then(/^I should see a guide on what to do on this page$/) do
  expect(page).to have_content('Please upload your documents to complete your registration.')
end

Given(/^my document has been successfully uploaded and I have received confirmation$/) do
  attach_file('document_upload', Rails.root.join('spec/fixtures/sample_document.pdf'))
  click_button('Upload')
  expect(page).to have_content('Upload successful')
end

When(/^authorized personnel access my uploaded documents for verification$/) do
  @document = Document.last
  @document.update(verified: true, consent_given: true)
end

Then(/^they should only be able to do so with my consent and appropriate security checks$/) do
  expect(@document.consent_given).to be true
  expect(page).to have_content('Consent and security checks in place')
end

Then(/^I should receive a notification that my documents are being reviewed$/) do
  expect(page).to have_content('Your documents are being reviewed')
end
