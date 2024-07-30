Then(/^I should see "([^"]*)"$/) do |name|
  expect(page).to have_content("#{name}", wait: 2) # Wait for up to 2 seconds
end

Then(/^I should not see "([^"]*)"$/) do |name|
  expect(page).to have_no_content(name, wait: 2) # Wait for up to 2 seconds
end

Then(/^I should see the following filled-in details$/) do |table|
  table.hashes.each do |row|
    step "I should see \"#{row['Field']}\""
    step "I should see \"#{row['Value']}\""
  end
end

Then(/^I should enter the "Home" page$/) do
  expect(current_path).to eq('/')
end

Then(/^I should stay on the "([^"]*)" page$/) do |page_name|
  expect(current_path).to eq(path_to(page_name))
end

Then(/^I should be redirected to the "([^"]*)" page$/) do |page_name|
  expect(current_path).to eq(path_to(page_name))
end

Given(/^that a User account by the Username of "([^"]*)", Email of "([^"]*)", Phone Number of "([^"]*)" exist$/) do |username, email, phone_number|
  user = User.find_by(username:, email:, phone_number:)
  expect(user).not_to be_nil, "No user found with Username: #{username}, Email: #{email}, Phone Number: #{phone_number}"
end

When(/^I press the "([^"]*)" button$/) do |btn_name|
  if has_button?(btn_name)
    click_button(btn_name)
  elsif has_link?(btn_name)
    click_link(btn_name)
  elsif has_css?("[aria_label='#{btn_name}']")
    find("[aria_label='#{btn_name}']").click
  else
    raise "No button or link found with name '#{btn_name}'"
  end
end
# Step to navigate to a specific page
Given(/^I am on the "([^"]*)" page$/) do |page|
  puts "Current URL: #{current_url}"
  visit path_to(page)
  puts "Current URL: #{current_url}"
end

When(/^I fill in the following fields$/) do |table|
  fill_in_form(table)
end
# Helper Methods

# Fills in a form based on the given table data
def fill_in_form(table)
  table.hashes.each do |row|
    case row['Field'].downcase
    when row['Field'] == 'Password'
      fill_in 'Password', with: row['Value'], match: :prefer_exact
    when 'country of origin'
      select row['Value'], from: row['Field']
    when 'ethnicity', 'religion', 'gender'
      # For dropdown fields
      select row['Value'], from: "#{row['Field'].downcase}_select"
    when 'date of birth', 'date of arrival in malaysia'
      # For HTML5 date fields, ensure the date is in 'YYYY-MM-DD' format
      fill_in row['Field'], with: row['Value'].to_date.strftime('%d-%m-%Y') unless row['Value'].to_s.strip.empty?
      # For regular input fields
    when 'phone number'
      select('+65', from: 'country_code_select') # Selects the country code from the dropdown
      fill_in 'phone_number_field', with: row['Value'] # Fills in the phone number field
    when 'secondary phone number'
      select('+65', from: 'country_code_select_secondary') # Selects the country code from the dropdown
      fill_in 'phone_number_field_secondary', with: row['Value'] # Fills in the phone number field
    else
      fill_in row['Field'], with: row['Value']
    end
  end
end

# Maps page names to their corresponding paths
def path_to(page_name)
  user_id = if has_selector?('#EnableID_usertitle')
              find('#EnableID_usertitle')['data-user-id']
            else
              nil
            end
  case page_name.downcase
  when 'home'
    user_particular_path(user_id)
  when 'login'
    new_user_session_path
  when 'ngogebirah'
    ngo_gebirah_path
  when 'user verification'
    user_verification_path
  when 'fill in particulars'
    new_user_particular_path
  when 'registration'
    new_user_registration_path
  when 'saved post'
    saved_post_user_particular_path(user_id)
  else
    raise "Undefined page: #{page_name}"
  end
end
