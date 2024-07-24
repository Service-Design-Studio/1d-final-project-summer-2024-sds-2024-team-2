# features/step_definitions/user_home_page_steps.rb

# Scenario: Generating a 2FA passcode
When(/^I click on the "Generate 2FA Passcode:" button$/) do
  # Wait for the button to appear and ensure it's not disabled
  expect(page).to have_button('Generate 2FA Passcode:', disabled: false)
  click_button('Generate 2FA Passcode:')
end

Then(/^I should see a 2FA passcode generated$/) do
  # Assuming the 2FA passcode is displayed in a specific element, adjust the selector accordingly
  expect(page).to have_css('#two-fa-passcode', visible: true)
  expect(find('#two-fa-passcode').text).not_to eq('2FA Passcode is not set up.')
end

# Scenario: Navigating to the Documents page
When(/^I press on the "Documents" button$/) do
  # Find the Documents link and click it
  find_link('Documents').click
end

Then(/^I should be redirected to the "Documents" page$/) do
  # Ensure the current path is the Documents page path
  expect(page).to have_current_path('http://127.0.0.1:3001/user_particulars/1/document', url: true)
end

# Scenario: Navigating to the Activity History page
When(/^I press on the "Activity History" button$/) do
  # Find the Activity History link and click it
  find_link('Activity History').click
end

Then(/^I should be redirected to the "Activity History" page$/) do
  # Ensure the current path is the Activity History page path
  expect(page).to have_current_path('http://127.0.0.1:3001/user_particulars/1/history', url: true)
end

And(/^I should see a list of my recent activities$/) do
  # Ensure the activity list is present on the page
  expect(page).to have_css('#user_history')
end

# Scenario: Navigating to the Edit Particulars page
When(/^I press on the "edit icon" button$/) do
  # Assuming there is an icon for editing particulars
  find('.fas.fa-edit').click
end

Then(/^I should be redirected to the "Edit Particulars" page$/) do
  # Ensure the current path is the Edit Particulars page path
  expect(page).to have_current_path('http://127.0.0.1:3001/user_particulars/1/edit', url: true)
end

Then(/^I should see the following fields with their respective values:$/) do |table|
  # Wait for the page to fully load and the form to be visible
  expect(page).to have_selector('.form-group', visible: true)

  # Iterate over each row in the table
  table.hashes.each do |row|
    field = row['Field']
    expected_value = row['Value']

    case field
    when 'Full Name'
      actual_value = find('input[name="user_particular[full_name]"]').value
    when 'Phone number'
      actual_value = find('input[name="user_particular[phone_number]"]').value
    when 'Secondary phone number (optional)'
      actual_value = find('input[name="user_particular[secondary_phone_number]"]').value
    when 'Country of Origin'
      actual_value = find('select[name="user_particular[country_of_origin]"]').find('option[selected]').text
    when 'Ethnicity'
      actual_value = find('select[name="user_particular[ethnicity]"]').find('option[selected]').text
    when 'Religion'
      actual_value = find('select[name="user_particular[religion]"]').find('option[selected]').text
    when 'Gender'
      actual_value = find('select[name="user_particular[gender]"]').find('option[selected]').text
    when 'Date of Birth'
      actual_value = find('input[name="user_particular[date_of_birth]"]').value
    when 'Date of Arrival in Malaysia'
      actual_value = find('input[name="user_particular[date_of_arrival]"]').value
    else
      raise "Unknown field: #{field}"
    end

    expect(actual_value).to eq(expected_value), "Expected #{field} to have value #{expected_value} but got #{actual_value}"
  end
end
