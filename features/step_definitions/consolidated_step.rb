# Method to fill in form fields based on the provided table data
def fill_in_form(table)
  table.hashes.each do |row|
    case row['Field'].downcase
    when 'ethnicity', 'religion', 'gender', 'country of origin'
      select row['Value'], from: row['Field']
    when 'date of birth', 'date of arrival in malaysia'
      # Format date values before filling them into fields
      fill_in row['Field'], with: row['Value'].to_date.strftime('%Y-%m-%d')
    else
      fill_in row['Field'], with: row['Value']
    end
  end
end

# Method to verify form data against the provided table data
def verify_form_data(table)
  table.hashes.each do |row|
    # Find the field and ensure it is visible before verifying its value
    field = find_field(row['Field'])
    expect(field).to be_visible
    expect(field.value).to eq row['Value']
  end
end

# Method to map page names to their corresponding paths
def path_to(page_name)
  case page_name.downcase
  when 'home'
    root_path
  when 'login'
    new_user_session_path
  when 'ngo: gebirah'
    ngo_gebirah_path
  when 'user verification'
    user_verification_path
  when 'fill in particulars'
    new_user_particular_path
  else
    raise "Undefined page: #{page_name}"
  end
end

# Step Definitions

Given(/^I am on the "([^"]*)" page$/) do |page|
  visit path_to(page)
end

When(/^I press the "([^"]*)" button$/) do |button|
  if page.has_button?(button)
    click_button(button)
  elsif page.has_link?(button)
    click_link(button)
  else
    raise "Button or link '#{button}' not found"
  end
end

Then(/^I should see a set of different NGO buttons$/) do
  # Wait for up to 10 seconds for the button to appear and be visible
  expect(page).to have_selector('.btn', text: 'NGO Gebirah', visible: true, wait: 10)
end

Then(/^I should be redirected to the "([^"]*)" page$/) do |page|
  expect(current_path).to eq path_to(page)
end

And(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(/#{Regexp.escape(text)}/)
end

Then(/^I will see an error message "(.+)"$/) do |message|
  expect(page).to have_content(/#{Regexp.escape(message)}/)
end

Then(/^I should see the following fields in the Digital ID:$/) do |table|
  verify_form_data(table)
end

When(/^I fill in the "([^"]*)" field with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

And(/^I leave the "([^"]*)" field empty$/) do |field|
  fill_in field, with: ''
end

Then(/^I will see a welcome message "(.+)"$/) do |message|
  expect(page).to have_content(/#{Regexp.escape(message)}/)
end

Given(/^I entered? the following particulars?:$/) do |table|
  fill_in_form(table)
end

And(/^I do not enter a date of birth$/) do
  fill_in 'Date of Birth', with: ''
end

And(/^I do not select a country of origin$/) do
  select '', from: 'Country of Origin'
end

Then(/^I should see the following fields?:$/) do |table|
  table.hashes.each do |row|
    expect(page).to have_content(row['Value'])
  end
end

Given(/^I am already on my "([^"]*)" page$/) do |page|
  visit path_to(page)
end

When(/^I key in the undocumented user's unique EnableID number: (\d+)$/) do |enable_id_number|
  fill_in 'EnableID Number', with: enable_id_number
end

When(/^I press "([^"]*)"$/) do |button|
  if page.has_button?(button)
    click_button(button)
  elsif page.has_link?(button)
    click_link(button)
  else
    raise "Button or link '#{button}' not found"
  end
end

Then(/^I should see "([^"]*)" with a textbox$/) do |text|
  expect(page).to have_content(text)
  expect(page).to have_selector('input[type="text"]')
end

When(/^I key in a 6 digit code that is seen on his\/her EnableID: (\d+)$/) do |code|
  fill_in '2FA Code', with: code
end

Then(/^I should see his\/her EnableID card$/) do
  expect(page).to have_selector('.enableid-card')
end

And(/^a "([^"]*)" button below$/) do |button_text|
  expect(page).to have_button(button_text)
end
