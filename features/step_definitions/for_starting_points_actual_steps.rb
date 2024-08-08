# features/step_definitions/for_starting_points_actual_steps.rb

# Brendan: Starting point for NGO show page
Given(/^I am already on my NGO "([^"]*)" page$/) do |ngo_name|
  step 'I am on the "Login" page'
  step 'I press the "I am a NGO" button'
  step %(I press the "#{ngo_name}" button)
end

# Fawziyah: Starting point for User_particulars show page
Given(/^I am now on the user particulars home page as a new user$/) do
  step 'I am on the "Login" page'
  user = User.find_by(username: 'newuser')
  raise "User creation failed: #{user.errors.full_messages.join(', ')}" unless user.persisted?

  fill_in 'Log in EnableID', with: user.username
  fill_in 'Password', with: 'newuserpassword'
  step 'I press the "Log in" button'
  visit root_path
  expected_path = '/'
  raise "Expected to be on #{expected_path}, but was on #{current_path}" unless current_path == expected_path

  step 'I should see "Welcome, "'
end

# Yiqing: Starting point for NGO User Verification page
Given(/^I am already on NGO "Gebirah" verify a user page$/) do
  step 'I am on the "Login" page'
  step 'I press the "I am a NGO" button'
  step 'I press the "Gebirah" button'
  step 'I press the "Verify User" button'
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
  raise 'User not found' unless @user

  @user_particular = @user.user_particular
  raise 'User Particular not found' unless @user_particular

  login_as(@user, scope: :user)
  visit user_particular_path(@user_particular)
  expected_path = user_particular_path(@user_particular)
  raise "Expected to be on #{expected_path}, but was on #{current_path}" unless current_path == expected_path

  step 'I should see the welcome message'
  step 'I should see "EnableID - Verified by Gebirah"'
end

# Logged in and starting from user home page
Given(/^I am now logged in to the user particulars home page$/) do
  step 'I am on the "Login" page'
  fill_in 'Log in EnableID', with: 'user1'
  fill_in 'Password', with: 'password1'
  step 'I press the "Log in" button'
  @user = User.find_by(username: 'user1')
  raise 'User not found' unless @user

  @user_particular = @user.user_particular
  raise 'User Particular not found' unless @user_particular

  login_as(@user, scope: :user)
  visit user_particular_path(@user_particular)
  expected_path = user_particular_path(@user_particular)
  raise "Expected to be on #{expected_path}, but was on #{current_path}" unless current_path == expected_path
end

Then(/^I should see the welcome message$/) do
  expect(page).to have_content('Welcome, ', wait: 2)
end

# Getting started but as an already verified user
Given(/^I am now on the fill in your particulars page as a new user$/) do
  step('I am now on the user particulars home page as a new user')
  step('I press the "Fill in your particulars to get your Digital ID!" button')
  step('I should see "Fill in your particulars"')
end

# Linus could use this
Given(/^I am now on the upload documents page$/) do
  step('I am now on the fill in your particulars page as a new user')
  fill_in_form(Cucumber::MultilineArgument::DataTable.from([
                                                             ['Field', 'Value'],
                                                             ['Full Name', 'Alice Tan'],
                                                             ['Phone number', '99999999'],
                                                             ['Secondary phone number', '87654321'],
                                                             ['Country of Origin', 'Malaysia'],
                                                             ['Ethnicity', 'Rohingya'],
                                                             ['Religion', 'Islam'],
                                                             ['Gender', 'Female'],
                                                             ['Date of Birth', '12-04-2000'],
                                                             ['Date of Arrival in Malaysia', '20-01-2020']
                                                           ]))
  step('I press the "Submit" button')
  @user_particular = UserParticular.find_by(full_name: 'Alice Tan')
  raise 'User Particular not found' unless @user_particular

  visit new_user_particular_document_path(@user_particular)
end
