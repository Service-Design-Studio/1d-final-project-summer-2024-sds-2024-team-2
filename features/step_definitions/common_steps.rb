require 'capybara/rails'
require 'capybara/cucumber'
require 'capybara/dsl'

# When pressing button
When /^(?:|I )press "([^"]*)"$/ do |button|
  patiently do
    click_button(button)
  end
end

# Fill in table
Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end


Then(/^the fields should be empty$/) do
  expect(page).to have_field('Full Name', with: '')
  expect(page).to have_field('Phone Number', with: '')
  expect(page).to have_field('Secondary Phone Number', with: '')
  expect(page).to have_select('Country of Origin', selected: nil)
  expect(page).to have_select('Ethnicity', selected: nil)
  expect(page).to have_select('Religion', selected: nil)
  expect(page).to have_select('Gender', selected: nil)
  expect(page).to have_field('Date of Birth', with: '')
  expect(page).to have_field('Date of Arrival in Malaysia', with: '')
end

Given(/^I entered the following particulars:$/) do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
end

# See on page
Then(/^I will see a confirmation message "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end

# Redirect to page
Then(/^I will be redirected to the "(.*?)" page$/) do |page_name|
  expect(page).to have_current_path(path_to(page_name))
end

# Step definition for logging in successfully
Given(/^I am logged in successfully$/) do
  @user = User.create!(username: 'testuser', email: 'testuser@example.com', password: 'password123')
  visit path_to('login')
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
  expect(page).to have_content('Welcome')
end

# prompt to fill in
Then(/^I will be prompted to fill in the "(.*?)" field$/) do |field|
  expect(page).to have_content("#{field} can't be blank")
end

# status update
Then(/^the system displays my status as "(.*?)"$/) do |status|
  expect(page).to have_content(status)
end

# Step definition for retrieving existing personal details and documents
Then(/^the system retrieves my existing personal details and documents, if any$/) do
  @user.update(
    full_name: 'John Doe',
    date_of_birth: '1990-01-01',
    country_of_origin: 'CountryX',
    ethnicity: 'EthnicityX',
    religion: 'ReligionX',
    gender: 'Male',
    date_of_arrival_in_malaysia: '2020-01-01'
  )
  @documents = @user.uploaded_documents
end

When(/^(?:|I )fill in the following:$/) do |fields|
  fields.rows_hash.each do |name, value|
    steps %Q{
      When I fill in "#{name}" with "#{value}"
    }
  end
end

When(/^(?:|I )fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value, match: :prefer_exact
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

# Additional required helper method
def patiently
  retries = 0
  begin
    yield
  rescue Selenium::WebDriver::Error::ElementNotInteractableError
    retries += 1
    raise if retries >= 3
    sleep 1
    retry
  end
end

# Helper method to map page names to paths
def path_to(page_name)
  case page_name
  when 'home'
    root_path
  when 'login'
    new_user_session_path
  when 'registration'
    new_user_registration_path
  # Add more mappings as needed
  else
    raise "Path to #{page_name} is not defined"
  end
end
