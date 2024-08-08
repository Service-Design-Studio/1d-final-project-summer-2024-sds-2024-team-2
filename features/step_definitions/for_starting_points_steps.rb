Given('a user particular exists with unique ID {string} and 2FA code {string}') do |unique_id, two_fa_code|
  user_particular = UserParticular.first
  user_particular.update(unique_id:, two_fa_passcode: two_fa_code)
  expect(user_particular).not_to be_nil
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

When(/^I key in the Unique ID: '([^"]*)" and 6 digit code 2FA: "([^"]*)", then I press the check button$/) do |unique_id, two_fa_code|
  # Wait for the unique ID field to be present
  find('#unique_id', wait: 10).set(unique_id) # Replace '#unique_id' with the actual field identifier

  # Wait for the 2FA code field to be present
  find('#two_fa_passcode', wait: 10).set(two_fa_code) # Replace '#two_fa_passcode' with the actual field identifier

  step 'I press the "Check" button'
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
