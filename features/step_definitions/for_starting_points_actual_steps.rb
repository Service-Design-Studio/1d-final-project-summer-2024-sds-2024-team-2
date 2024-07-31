# features/step_definitions/for_starting_points_actual_steps.rb

# Brendan: Starting point for NGO show page
Given(/^I am already on my NGO "([^"]*)" page$/) do |ngo_name|
  step 'I am on the "Login" page'
  step 'I press the button "I am a NGO"'
  step %(I press the button "#{ngo_name}")
end

# Fawziyah: Starting point for User_particulars show page
Given(/^I am now on the user particulars home page as a new user$/) do
  step 'I am on the "Login" page'
  user = User.find_by(username: 'newuser')
  raise "User creation failed: #{user.errors.full_messages.join(', ')}" unless user.persisted?

  fill_in 'Log in EnableID', with: user.username
  fill_in 'Password', with: "newuserpassword"
  step 'I press the button "Log in"'
  visit root_path
  expected_path = '/'
  raise "Expected to be on #{expected_path}, but was on #{current_path}" unless current_path == expected_path

  step 'I should see "Welcome, "'
end

# Yiqing: Starting point for NGO User Verification page
Given(/^I am already on NGO "Gebirah" verify a user page$/) do
  step 'I am on the "Login" page'
  step 'I press the button "I am a NGO"'
  step 'I press the button "Gebirah"'
  step 'I press the button "Verify User"'
  step 'I key in the Unique ID: \'1055290\' and 6 digit code 2FA: "606833", then I press the check button'
  step 'I should be redirected to the User Verification page under "Gebirah"'
  step 'I should see his/her EnableID card'
  step 'I should see "1055290"'
  step 'I should see "Verify" button'
end

# Getting started but as an already verified user
Given(/^I am now on the user particulars home page as a verified user$/) do
  step 'I am on the "Login" page'
  fill_in 'Log in EnableID', with: 'user1'
  fill_in 'Password', with: 'password1'
  step 'I press the "Log in" button'
  @user = User.find_by(username: 'user1')
  login_as(@user, scope: :user)
  visit user_particular_path(@user)
  expected_path = user_particular_path(@user)
  raise "Expected to be on #{expected_path}, but was on #{current_path}" unless current_path == expected_path

  step 'I should see the welcome message'
  step 'I should see "EnableID - Verified by Gebirah"'
end

Then(/^I should see the welcome message$/) do
  expect(page).to have_content("Welcome, ", wait: 2)
end
