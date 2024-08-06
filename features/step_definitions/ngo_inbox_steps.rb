Given('I am already on the Contact NGO page') do
  step 'I press the "Search Services" button'
  step 'I should be directed to the "Contact NGO" page'
end


When('I click on the send message button') do
  all('.button-container-service')[5].click
end

Then('I should open up a message modal with {string} as the header') do |expected_header|
  # Wait for the modal to be visible
  expect(page).to have_css('#editModal', visible: true)

  # Verify the modal header text
  modal_header = find('#editModal .modal-header .modal-title').text
  expect(modal_header).to eq(expected_header)
end

When('I fill in the message form with {string}') do |message|
  within('#editModal') do
    fill_in 'message-text', with: message
  end
end

When('I submit the message form') do
  within('#editModal') do
    find('.save-btn').click
  end
end

Then('I should see a flash message {string}') do |message|
  expect(page).to have_content(message)
end

