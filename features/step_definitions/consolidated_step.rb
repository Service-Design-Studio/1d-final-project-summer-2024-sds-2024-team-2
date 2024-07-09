# frozen_string_literal: true

# Helper Methods

# Method to fill in form fields based on the provided table data
def fill_in_form(table)
  table.hashes.each do |row|
    case row['Field'].downcase
    when 'ethnicity', 'religion', 'gender', 'country of origin'
      select row['Value'], from: row['Field']
    when 'date of birth', 'date of arrival in malaysia'
      fill_in row['Field'], with: row['Value'].to_date.strftime('%Y-%m-%d')
    else
      fill_in row['Field'], with: row['Value']
    end
  end
end

# Method to verify form data against the provided table data
def verify_form_data(table)
  table.hashes.each do |row|
    field = find_field(row['Field'])
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

Given(/^I fill in the following:$/) do |table|
  fill_in_form(table)
end

Then(/^I will see an error message "(.+)"$/) do |message|
  expect(page).to have_content(/#{message}/)
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
  expect(page).to have_content(/#{message}/)
end

Given(/^I entered the following particulars:$/) do |table|
  fill_in_form(table)
end

And(/^I do not enter a date of birth$/) do
  fill_in 'Date of Birth', with: ''
end

And(/^I do not select a country of origin$/) do
  select '', from: 'Country of Origin'
end

Then(/^I should see the following fields:$/) do |table|
  puts "Current URL: #{current_url}"
  puts "Current Path: #{current_path}"
  table.hashes.each do |row|
    expect(page).to have_content(row['Value'])
  end
end

Given(/^I am on the "([^"]*)" page$/) do |page|
  visit path_to(page)
end

And(/^I press the "([^"]*)" button$/) do |button|
  click_button(button)
end

Given('I am a logged-in user') do
  @user = create(:user)
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button('Log in')
  expect(page).to have_content(/Signed in successfully./)
end

Given(/^I enter the following details on the (phone number|email|username) login page:$/) do |login_type, table|
  details = table.hashes.first
  case login_type
  when 'phone number'
    fill_in 'Phone Number', with: details['Phone Number']
  when 'email'
    fill_in 'Email', with: details['Email']
  when 'username'
    fill_in 'Username', with: details['Username']
  end
  fill_in 'Password', with: details['Password']
end

When(/^I enter the following login details:$/) do |table|
  details = table.hashes.first
  fill_in 'Phone Number', with: details['Phone Number'] if details['Phone Number']
  fill_in 'Email', with: details['Email'] if details['Email']
  fill_in 'Username', with: details['Username'] if details['Username']
  fill_in 'Password', with: details['Password']
end

When(/^I key in the undocumented user's unique EnableID number: (\d+)$/) do |number|
  fill_in 'EnableID', with: number
end

When(/^I key in a 6 digit code that is seen on his\/her EnableID: (\d+)$/) do |code|
  fill_in '2FA Code', with: code
end

Then(/^I should see his\/her EnableID card$/) do
  expect(page).to have_selector('#enableIDCard')
end

Then(/^I should see a "Verify" button below$/) do
  expect(page).to have_button(/Verify/)
end

Then(/^I should see "Successfully verified EnableID: (\d+)!"$/) do |enableID|
  expect(page).to have_content(/Successfully verified EnableID: #{enableID}!/)
end

Then(/^I should see the checkmark on the user's EnableID card$/) do
  expect(page).to have_selector('#enableIDCard .checkmark')
end

Then(/^I should see "EnableID - verified by NGO: Gebirah"$/) do
  expect(page).to have_content(/EnableID - verified by NGO: Gebirah/)
end

Then(/^I should see "Date of verification: (.+)"$/) do |date|
  expect(page).to have_content(/Date of verification: #{date}/)
end

Then(/^I should see a set of different NGO buttons$/) do
  expect(page).to have_selector('button.ngo-buttons')
end

Then(/^I should be redirected to the "([^"]*)" page$/) do |page|
  expect(current_path).to eq path_to(page)
end

And(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(/#{text}/)
end
