Given('a user particular exists with unique ID {string} and 2FA code {string}') do |unique_id, two_fa_code|
  user_particular = UserParticular.find_by(unique_id:, two_fa_passcode: two_fa_code)
  expect(user_particular).not_to be_nil
end

When(/^I press the "([^"]*)" button$/) do |btn_name|
  if has_button?(btn_name)
    click_button(btn_name)
  elsif has_link?(btn_name)
    click_link(btn_name)
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

Then('I should see a set of different NGO buttons') do
  expect(page).to have_selector('.ngo_table')
end

When(/^I press the NGO "([^"]*)" card$/) do |image_alt|
  image = find("img[alt='#{image_alt} image']", wait: 10)
  card_link = image.find(:xpath, './/ancestor::a[@class="card-link"]')
  card_link.click
end

Then(/^I should be redirected to the User Verification page under "([^"]*)"$/) do |ngo_name|
  @ngo_user = NgoUser.find_by(name: ngo_name)
  @user_particular = UserParticular.find_by(unique_id: '1055290', two_fa_passcode: '606833')
  puts verify_ngo_user_path(@ngo_user, unique_id: '1055290')
  using_wait_time(10) do
    expect(current_path).to eq("/ngo_users/#{@ngo_user.id}/verify")
  end
end

Then(/^I should be redirected to the NGO "([^"]*)" page$/) do |page_name|
  @ngo_user = NgoUser.find_by(name: page_name)
  expect(@ngo_user).not_to be_nil, "NgoUser with name #{page_name} not found."

  expected_path = "/ngo_users/#{@ngo_user.id}"
  expect(current_path).to eq(expected_path),
                          "Expected to be redirected to #{expected_path} but was at #{current_path} instead."
end

Then(/^I should see "([^"]*)"$/) do |name|
  expect(page).to have_content("#{name}")
end

When(/^I key in the Unique ID: '([^"]*)" and 6 digit code 2FA: "([^"]*)", then I press the check button$/) do |unique_id, two_fa_code|
  fill_in 'unique_id', with: unique_id # Replace 'unique_id_field' with the actual field identifier
  fill_in 'two_fa_passcode', with: two_fa_code # Replace 'two_fa_code_field' with the actual field identifier
  click_button 'Check'
end

Then('I should see his\/her EnableID card') do
  step 'I should see "EnableID Digital Card"'
end

Then(/^I should see "([^"]*)" button$/) do |button_text|
  expect(page).to have_selector(".btn[value='#{button_text}']")
end

Given(/^I have a user (\d+) verified by NGO: (.+), and logs in$/) do |user_id, ngo_name|
  @ngo_user = NgoUser.find_by(name: ngo_name)
  @user_particular = UserParticular.find_by(unique_id: user_id)
  @user = User.find_by(id: @user_particular.user_id)
  step 'I am on the "Home" page'
  login_as(@user, scope: :user)
  expect(page).to have_content('Welcome,')
end

When(/^I fill in the following fields$/) do |table|
  fill_in_form(table)
end

# Helper Methods
# Fills in a form based on the given table data
def fill_in_form(table)
  table.hashes.each do |row|
    case row['Field'].downcase
    when 'country of origin'
      select row['Value'], from: row['Field']
    when 'ethnicity', 'religion', 'gender'
      # For dropdown fields
      select row['Value'], from: "#{row['Field'].downcase}_select"
    when 'date of birth', 'date of arrival in malaysia'
      # For HTML5 date fields, ensure the date is in 'YYYY-MM-DD' format
      fill_in row['Field'], with: row['Value'].to_date.strftime('%d-%m-%Y')
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
  case page_name.downcase
  when 'home'
    root_path
  when 'login'
    new_user_session_path
  when 'ngogebirah'
    ngo_gebirah_path
  when 'user verification'
    user_verification_path
  when 'fill in particulars'
    new_user_particular_path
  else
    raise "Undefined page: #{page_name}"
  end
end
