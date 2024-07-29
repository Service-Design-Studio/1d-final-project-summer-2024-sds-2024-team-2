Given(/^I am an undocumented individual$/) do
  # Code to set up the user as an undocumented individual
  @user = User.create!(status: 'undocumented', registered: false)
end

Given(/^I have completed the initial registration process$/) do
  # Code to set up that the user has completed the initial registration
  @user.update(registered: true)
end

Given(/^I need to upload my documents to complete my digital identity$/) do
  # Code to indicate the need for document upload to complete digital identity
  @user.update(needs_document_upload: true)
end

# Given(/^I am on the "([^"]*)" page$/) do |page|
#   visit path_to(page)
# end

# When(/^I press the "([^"]*)" button$/) do |button|
#   click_button(button)
# end

# Then(/^I should be directed to the "([^"]*)" page$/) do |page|
#   expect(page).to have_current_path(path_to(page))
# end

When(/^I drag a document file into the designated drop area$/) do
  # Code to simulate dragging a document file into the drop area
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

# Then(/^I should see an error message stating "([^"]*)"$/) do |message|
#   expect(page).to have_content(message)
# end

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

# Then(/^I should see a guide on what to do on this page$/) do
#   expect(page).to have_content('Please upload your documents to complete your registration.')
# end

Given(/^my document has been successfully uploaded and I have received confirmation$/) do
  # Assuming document upload and confirmation are set
  attach_file('document_upload', Rails.root.join('spec/fixtures/sample_document.pdf'))
  click_button('Upload')
  expect(page).to have_content('Upload successful')
end

When(/^authorized personnel access my uploaded documents for verification$/) do
  # Simulate the action of authorized personnel accessing documents
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
