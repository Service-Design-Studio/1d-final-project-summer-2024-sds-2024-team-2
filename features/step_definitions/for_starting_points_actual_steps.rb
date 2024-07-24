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
Given(/^I am already on NGO "Gebirah" verify a user page$/) do
  step 'I am on the "Login" page'
  step 'I press the "I am a NGO" button'
  step 'I press the NGO "Gebirah" card'
  step 'I press the "Verify User" button'
  step 'I key in the Unique ID: \'1055290" and 6 digit code 2FA: "606833", then I press the check button'
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
  user = User.find_by(username: 'user1')
  login_as(user, scope: :user)
  visit root_path
  expected_path = '/'
  raise "Expected to be on #{expected_path}, but was on #{current_path}" unless current_path == expected_path

  step 'I should see "Welcome, "'
  step 'I should see "EnableID - Verified by Gebirah"'
  # Set this before running your tests
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
  # step('I should see "Select documents to upload"')
end
