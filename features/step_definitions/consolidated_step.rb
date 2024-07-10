# features/step_definitions/consolidated_step.rb

module PathHelper
  include Rails.application.routes.url_helpers

  # Method to get the path for different pages
  def path_to(page_name)
    case page_name.downcase
    when 'home' then root_path
    when 'login' then new_user_session_path
    when 'ngo: gebirah' then ngo_user_path(NgoUser.find_by(name: 'Gebirah')) # Path to the NGO Gebirah page
    when 'user verification' then root_path # Fallback to home and navigate manually
    when 'fill in particulars' then new_user_particular_path
    when 'ngo search' then ngo_users_path
    else raise "Undefined page: #{page_name}"
    end
  end
end

World(PathHelper)

# Global Before Hook to Create Necessary Test Data
Before do
  # Create a user with valid attributes
  @user = User.find_or_create_by(email: 'test_user@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
    user.username = 'testuser'
    user.phone_number = '1234567890'
    user.save! # Ensure the record is saved with updated attributes
  end

  # Create or find the NgoUser with the name 'Gebirah'
  @gebirah = NgoUser.find_or_create_by(name: 'Gebirah') do |ngo_user|
    ngo_user.save! # Ensure the record is saved with updated attributes
  end

  # Create or find a UserParticular with the unique_id '1004209' and associate with the user
  @user_particular = UserParticular.find_or_create_by(unique_id: '1004209') do |user_particular|
    user_particular.user = @user
    user_particular.two_fa_passcode = '958523'
    user_particular.save! # Ensure the record is saved with updated attributes
  end

  # Debugging output to confirm the setup
  puts "UserParticular created with unique_id: #{@user_particular.unique_id}, user_id: #{@user_particular.user_id}, two_fa_passcode: #{@user_particular.two_fa_passcode}"
end

# Step Definitions

Given(/^I am on the "(.+)" page$/) do |page|
  visit path_to(page)
end

Given(/^I navigate to the "(.+)" page$/) do |page|
  visit path_to(page)
end

When(/^I press (?:the )?"(.+)" (?:button|link)$/) do |button|
  click_button_or_link(button)
end

Then(/^I should see a set of different NGO buttons$/) do
  using_wait_time 20 do
    unless page.has_selector?('#ngo-results .card-link', visible: true)
      puts "HTML Content of the page: \n#{page.html}" # Debugging statement
    end
    expect(page).to have_selector('#ngo-results .card-link', visible: true)
  end
end

Then(/^I should be redirected to the "(.+)" page$/) do |page|
  expected_path = path_to(page)
  actual_path = current_path
  unless actual_path == expected_path
    puts "Expected Path: #{expected_path}, Actual Path: #{actual_path}" # Debugging statement
  end
  expect(actual_path).to eq(expected_path)
end

Then(/^I should see "(.+)"$/) do |text|
  expect(page).to have_content(/#{Regexp.escape(text)}/)
end

Then(/^I will see an error message "(.+)"$/) do |message|
  expect(page).to have_content(/#{Regexp.escape(message)}/)
end

Then(/^I should see the following fields in the Digital ID:$/) do |table|
  verify_form_data(table)
end

When(/^I fill in the "(.+)" field with "(.+)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I leave the "(.+)" field empty$/) do |field|
  fill_in field, with: ''
end

Then(/^I will see a welcome message "(.+)"$/) do |message|
  expect(page).to have_content(/#{Regexp.escape(message)}/)
end

Given(/^I entered the following particulars:$/) do |table|
  fill_in_form(table)
end

When(/^I do not enter a date of birth$/) do
  fill_in 'Date of Birth', with: ''
end

When(/^I do not select a country of origin$/) do
  select '', from: 'Country of Origin'
end

Then(/^I should see the following fields:$/) do |table|
  table.hashes.each do |row|
    expect(page).to have_content(row['Value'])
  end
end

Given(/^I am already on my "(.+)" page$/) do |page|
  visit path_to(page)
end

When(/^I key in the undocumented user's unique EnableID number: (\d+)$/) do |enable_id_number|
  using_wait_time 20 do
    unless page.has_field?('unique_id', disabled: false) # Correct field name is 'unique_id'
      puts "HTML Content of the page: \n#{page.html}" # Debugging statement
    end
    fill_in 'unique_id', with: enable_id_number # Use correct field name
  end
end

When(/^I press "Submit"$/) do
  click_button_or_link('Submit')
end

Then(/^I should see "(.+)" with a textbox$/) do |text|
  expect(page).to have_content(/#{Regexp.escape(text)}/)
  expect(page).to have_selector('input[type="text"]')
end

When(/^I key in a 6 digit code that is seen on his\/her EnableID: (\d+)$/) do |code|
  fill_in '2FA Code', with: code
end

Then(/^I should see his\/her EnableID card$/) do
  expect(page).to have_selector('.enableid-card')
end

Then(/^a "(.+)" button below$/) do |button_text|
  expect(page).to have_button(button_text)
end

Given(/^that I am logged into user (\d+) EnableID account$/) do |user_id|
  visit new_user_session_path
  using_wait_time 20 do
    if page.has_field?('Email')
      fill_in 'Email', with: 'test_user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
    else
      puts "HTML Content of the login page: \n#{page.html}" # Debugging statement
      raise "Field 'Email' not found"
    end
  end
end

Then(/^I should see the checkmark on the user's EnableID card$/) do
  expect(page).to have_selector('.enableid-card .checkmark')
end

Then(/^I should see "EnableID - verified by NGO: Gebirah"$/) do
  expect(page).to have_content('EnableID - verified by NGO: Gebirah')
end

Then(/^I should see "Date of verification: #{Date.today}"$/) do
  expect(page).to have_content("Date of verification: #{Date.today}")
end

# Helper Methods

# Helper method to select or fill in a field
def select_or_fill_in(field, value)
  if %w(ethnicity religion gender country of origin).include?(field.downcase)
    select value, from: field
  else
    fill_in field, with: value
  end
end

# Helper method to fill in a date field
def fill_in_date(field, value)
  fill_in field, with: value.to_date.strftime('%Y-%m-%d')
end

# Helper method to click a button or link
def click_button_or_link(button)
  using_wait_time 20 do
    if page.has_button?(button)
      click_button(button)
    elsif page.has_link?(button)
      click_link(button)
    elsif page.has_css?('.card-title', text: /#{Regexp.escape(button)}/)
      find('.card-title', text: /#{Regexp.escape(button)}/).click
    elsif page.has_css?('.card-link', text: /#{Regexp.escape(button)}/)
      find('.card-link', text: /#{Regexp.escape(button)}/).click
    else
      within('#ngo-results') do
        if page.has_css?('.card-title', text: /#{Regexp.escape(button)}/)
          find('.card-title', text: /#{Regexp.escape(button)}/).click
        elsif page.has_css?('.card-link', text: /#{Regexp.escape(button)}/)
          find('.card-link', text: /#{Regexp.escape(button)}/).click
        else
          puts "Available card titles: #{page.all('.card-title').map(&:text).join(', ')}" # Debugging statement
        end
      end
    end
  end
rescue Capybara::ElementNotFound => e
  puts "HTML Content of the page: \n#{page.html}" # Debugging statement
  raise e
end

# Helper method to fill in a form with table data
def fill_in_form(table)
  table.hashes.each do |row|
    field = row['Field']
    value = row['Value']
    select_or_fill_in(field, value)
  end
end

# Helper method to verify form data
def verify_form_data(table)
  table.hashes.each do |row|
    field = row['Field']
    value = row['Value']
    if page.has_field?(field)
      expect(find_field(field).value).to eq(value)
    elsif page.has_select?(field)
      expect(find(:select, field).value).to eq(value)
    else
      raise "Field #{field} not found"
    end
  end
end
