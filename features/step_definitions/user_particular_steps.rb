# Account Registration Step Definitions

# Step definition for navigating to the signup page
Given('I am on the signup page') do
  visit new_user_registration_path
end

# Step definition for clicking the register button
When('I press the register button') do
  click_button 'Sign up'
end

# Step definition for verifying the confirmation message
Then('I will see a confirmation message {string}') do |message|
  expect(page).to have_content(message)
end

# Step definition for verifying redirection to the login page
Then('I will be redirected to the login page') do
  expect(page).to have_current_path(new_user_session_path)
end

# Step definition for verifying error messages
Then('I will see an error message {string}') do |message|
  expect(page).to have_content(message)
end

# Step definition for verifying that the user remains on the signup page
Then('I will remain on the signup page') do
  expect(page).to have_current_path(user_registration_path)
end

# Step definition for filling in the registration form correctly
Given('I fill in the username, email, phone number, password, and confirm password fields correctly') do
  fill_in 'Username', with: 'testuser'
  fill_in 'Email', with: 'testuser@example.com'
  fill_in 'Phone number', with: '1234567890'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'password123'
end

# Step definition for missing username field
Given('I do not fill in the username field') do
  fill_in 'Email', with: 'testuser@example.com'
  fill_in 'Phone number', with: '1234567890'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'password123'
end

# Step definition for using an existing username
Given('I fill in a username that already exists, email, phone number, password, and confirm password fields correctly') do
  User.create!(username: 'existinguser', email: 'existinguser@example.com', password: 'password123',
               phone_number: '1234567890')
  fill_in 'Username', with: 'existinguser'
  fill_in 'Email', with: 'newemail@example.com'
  fill_in 'Phone number', with: '1234567890'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'password123'
end

# Step definition for password mismatch
Given('the confirm password field does not match the password field') do
  fill_in 'Username', with: 'testuser'
  fill_in 'Email', with: 'testuser@example.com'
  fill_in 'Phone number', with: '1234567890'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'differentpassword'
end

# Step definition for invalid email format
Given('I fill in the username, email with an invalid format, phone number, password, and confirm password fields correctly') do
  fill_in 'Username', with: 'testuser'
  fill_in 'Email', with: 'invalid-email-format'
  fill_in 'Phone number', with: '1234567890'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'password123'
end

# User Login Step Definitions

# Step definition for navigating to the login page
Given('I am on the login page') do
  visit new_user_session_path
end

# Step definition for clicking the login button
When('I press the login button') do
  click_button 'Log in'
end

# Step definition for verifying successful login and redirection to dashboard
Then('I will be logged in successfully') do
  expect(page).to have_current_path(account_dashboard_path)
end

# Step definition for verifying welcome message
Then('I will see a welcome message {string}') do |message|
  expect(page).to have_content(message)
end

# Step definition for verifying error messages
Then('I will see an error message {string}') do |message|
  expect(page).to have_content(message)
end

# Step definition for verifying that the user remains on the login page
Then('I will remain on the login page') do
  expect(page).to have_current_path(new_user_session_path)
end

# Step definition for filling in the username field
Given('I fill in the username field with {string}') do |username|
  fill_in 'Username', with: username
end

# Step definition for filling in the password field
Given('I fill in the password field with {string}') do |password|
  fill_in 'Password', with: password
end

# Step definition for leaving the username field empty
Given('I leave the username field empty') do
  fill_in 'Username', with: ''
end

# View Personal Information Step Definitions

# Step definition for logging in successfully
Given('I am logged in successfully') do
  # Assuming you have a helper method to log in a user
  @user = User.create!(username: 'testuser', email: 'testuser@example.com', password: 'password123')
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
  expect(page).to have_content('Welcome')
end

# Step definition for navigating to the personal information page
When('I navigate to the personal information page') do
  visit personal_information_path
end

# Step definition for retrieving and displaying personal details
Then('the system retrieves my personal details') do
  # Assuming the user model has the necessary attributes
  @user.update(
    full_name: 'John Doe',
    date_of_birth: '1990-01-01',
    country_of_origin: 'CountryX',
    ethnicity: 'EthnicityX',
    religion: 'ReligionX',
    gender: 'Male',
    date_of_arrival_in_malaysia: '2020-01-01',
    status: 'Pending verification'
  )
end

Then('the system displays my personal details including full name, date of birth, country of origin, ethnicity, religion, gender, date of arrival in Malaysia, and uploaded documents') do
  expect(page).to have_content(@user.full_name)
  expect(page).to have_content(@user.date_of_birth)
  expect(page).to have_content(@user.country_of_origin)
  expect(page).to have_content(@user.ethnicity)
  expect(page).to have_content(@user.religion)
  expect(page).to have_content(@user.gender)
  expect(page).to have_content(@user.date_of_arrival_in_malaysia)
  # Assuming there's a method to get uploaded documents
  @user.uploaded_documents.each do |document|
    expect(page).to have_content(document.file_name)
  end
end

Then('the system displays my status as {string}') do |status|
  expect(page).to have_content(status)
end

# Step definition for empty personal details
Given('my personal details are empty') do
  @user.update(
    full_name: '',
    date_of_birth: '',
    country_of_origin: '',
    ethnicity: '',
    religion: '',
    gender: '',
    date_of_arrival_in_malaysia: '',
    status: ''
  )
end

Then('the system displays empty fields') do
  expect(page).to have_field('Full name', with: '')
  expect(page).to have_field('Date of birth', with: '')
  expect(page).to have_field('Country of origin', with: '')
  expect(page).to have_field('Ethnicity', with: '')
  expect(page).to have_field('Religion', with: '')
  expect(page).to have_field('Gender', with: '')
  expect(page).to have_field('Date of arrival in Malaysia', with: '')
end

Then('the system shows a notice prompting me to fill in my information') do
  expect(page).to have_content('Please fill in your information')
end

# Step definition for viewing uploaded documents
When('I click on the button beside an uploaded document') do
  click_button 'View Document'
end

Then('the system retrieves the list of uploaded documents') do
  @documents = @user.uploaded_documents
end

Then('the system displays the list of uploaded documents with a button beside each document') do
  @documents.each do |document|
    expect(page).to have_content(document.file_name)
    expect(page).to have_button('View Document')
  end
end

Then('the system verifies the existence of the document') do
  @documents.each do |document|
    expect(File.exist?(document.file_path)).to be_truthy
  end
end

Then('the system displays the document to me') do
  @documents.each do |document|
    expect(page).to have_content(document.content)
  end
end

# Edit Personal Information Step Definitions

# Step definition for logging in successfully
Given('I am logged in successfully') do
  # Assuming you have a helper method to log in a user
  @user = User.create!(username: 'testuser', email: 'testuser@example.com', password: 'password123')
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
  expect(page).to have_content('Welcome')
end

# Step definition for verifying user status
Given('my status is {string}') do |status|
  @user.update(status:)
end

# Step definition for clicking the "Edit Information" button
When('I click on the {string} button') do |button|
  click_button button
end

# Step definition for retrieving existing personal details and documents
Then('the system retrieves my existing personal details and documents, if any') do
  @user.update(
    full_name: 'John Doe',
    date_of_birth: '1990-01-01',
    country_of_origin: 'CountryX',
    ethnicity: 'EthnicityX',
    religion: 'ReligionX',
    gender: 'Male',
    date_of_arrival_in_malaysia: '2020-01-01'
  )
  # Assuming a method to retrieve documents
  @documents = @user.uploaded_documents
end

# Step definition for entering personal details and uploading documents
Then('I enter my full name, date of birth, country of origin, ethnicity, religion, gender, date of arrival in Malaysia, and upload any necessary documents') do
  fill_in 'Full name', with: @user.full_name
  fill_in 'Date of birth', with: @user.date_of_birth
  fill_in 'Country of origin', with: @user.country_of_origin
  fill_in 'Ethnicity', with: @user.ethnicity
  fill_in 'Religion', with: @user.religion
  fill_in 'Gender', with: @user.gender
  fill_in 'Date of arrival in Malaysia', with: @user.date_of_arrival_in_malaysia
  # Assuming a file upload input
  attach_file('Document', @documents.first.file_path) if @documents.any?
end

# Step definition for saving the entered information
And('I save the entered information') do
  click_button 'Save'
end

# Step definition for validating and saving personal information
Then('the system validates and saves my personal information') do
  expect(@user.reload.full_name).to eq('John Doe')
  expect(@user.date_of_birth).to eq('1990-01-01')
  expect(@user.country_of_origin).to eq('CountryX')
  expect(@user.ethnicity).to eq('EthnicityX')
  expect(@user.religion).to eq('ReligionX')
  expect(@user.gender).to eq('Male')
  expect(@user.date_of_arrival_in_malaysia).to eq('2020-01-01')
end

# Step definition for displaying updated personal details
Then('the system displays the updated personal details') do
  expect(page).to have_content('John Doe')
  expect(page).to have_content('1990-01-01')
  expect(page).to have_content('CountryX')
  expect(page).to have_content('EthnicityX')
  expect(page).to have_content('ReligionX')
  expect(page).to have_content('Male')
  expect(page).to have_content('2020-01-01')
end

# Step definition for hiding the "Edit Information" button
Then('the {string} button is hidden') do |button|
  expect(page).not_to have_button(button)
end

# Step definition for leaving a required field empty
When('I leave a required field empty {string}') do |field|
  fill_in field, with: ''
end

# Step definition for trying to save the information
And('I try to save the information') do
  click_button 'Save'
end

# Step definition for displaying an error message
Then('the system displays an error message {string}') do |message|
  expect(page).to have_content(message)
end

# Step definition for remaining on the edit information page
And('I remain on the edit information page to correct the information') do
  expect(page).to have_current_path(edit_personal_information_path)
end
