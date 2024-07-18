# Brendan: Starting point for NGO show page
Given(/^I am already on my NGO "([^"]*)" page$/) do |ngo_name|
  step 'I am on the "Login" page'
  step 'I press the "I am a NGO" button'
  step %(I press the NGO "#{ngo_name}" card)
end

# Fawziyah: Starting point for User_particulars show page
Given(/^I am now on the user particulars home page as a new user$/) do
  step 'I am on the "Login" page'
  user = User.find_by(username: 'newuser')
  # Debugging: Check if user was successfully created
  raise "User creation failed: #{user.errors.full_messages.join(', ')}" unless user.persisted?

  fill_in 'Log in EnableID', with: user.username
  fill_in 'Password', with: user.password
  step 'I press the "Log in" button'
  login_as(user, scope: :user)
  visit root_path
  expected_path = '/'
  raise "Expected to be on #{expected_path}, but was on #{current_path}" unless current_path == expected_path

  step 'I should see "Welcome, "'
  # Set this before running your tests
end

# Yiqing: Starting point for NGO User Verification page

Given('I am already on NGO "Gebirah" verify a user page') do
  step 'I am on the "Login" page'
  step 'I press the "I am a NGO" button'
  step 'I press the NGO "Gebirah" card'
  step 'I key in the Unique ID: \'3665753" and 6 digit code 2FA: "310263", then I press the check button'
  step 'I should be redirected to the User Verification page under "Gebirah"'
  step 'I should see his/her EnableID card'
  step 'I should see "3665753"'
  step 'I should see "Verify" button'
end
