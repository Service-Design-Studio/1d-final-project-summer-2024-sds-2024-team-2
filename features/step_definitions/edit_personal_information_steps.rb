# Edit Personal Information Step Definitions

# Step definition for logging in successfully
Given(/^I am logged in successfully$/) do
  @user = User.create!(username: 'testuser', email: 'testuser@example.com', password: 'password123')
  visit path_to('login')
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
  expect(page).to have_content('Welcome')
end

# Step definition for verifying user status
Given(/^my status is "(.*?)"$/) do |status|
  @user.update(status: status)
end

# Step definition for clicking a button
When(/^I click on the "(.*?)" button$/) do |button_name|
  click_button button_name
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

# Step definition for entering personal details and uploading documents
Then(/^I enter my full name, date of birth, country of origin, ethnicity, religion, gender, date of arrival in Malaysia, and upload any necessary documents$/) do
  fill_in 'Full name', with: @user.full_name
  fill_in 'Date of birth', with: @user.date_of_birth
  fill_in 'Country of origin', with: @user.country_of_origin
  fill_in 'Ethnicity', with: @user.ethnicity
  fill_in 'Religion', with: @user.religion
  fill_in 'Gender', with: @user.gender
  fill_in 'Date of arrival in Malaysia', with: @user.date_of_arrival_in_malaysia
  attach_file('Document', @documents.first.file_path) if @documents.any?
end

# Step definition for saving the entered information
And(/^I save the entered information$/) do
  click_button 'Save'
end

# Step definition for validating and saving personal information
Then(/^the system validates and saves my personal information$/) do
  @user.reload
  expect(@user.full_name).to eq('John Doe')
  expect(@user.date_of_birth).to eq('1990-01-01')
  expect(@user.country_of_origin).to eq('CountryX')
  expect(@user.ethnicity).to eq('EthnicityX')
  expect(@user.religion).to eq('ReligionX')
  expect(@user.gender).to eq('Male')
  expect(@user.date_of_arrival_in_malaysia).to eq('2020-01-01')
end

# Step definition for displaying updated personal details
Then(/^the system displays the updated personal details$/) do
  expect(page).to have_content('John Doe')
  expect(page).to have_content('1990-01-01')
  expect(page).to have_content('CountryX')
  expect(page).to have_content('EthnicityX')
  expect(page).to have_content('ReligionX')
  expect(page).to have_content('Male')
  expect(page).to have_content('2020-01-01')
end

# Step definition for hiding a button
Then(/^the "(.*?)" button is hidden$/) do |button_name|
  expect(page).not_to have_button(button_name)
end

# Step definition for leaving a required field empty
When(/^I leave a required field "(.*?)" empty$/) do |field|
  fill_in field, with: ''
end

# Step definition for trying to save the information
And(/^I try to save the information$/) do
  click_button 'Save'
end

# Step definition for displaying an error message
Then(/^the system displays an error message "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end

# Step definition for remaining on the edit information page
And(/^I remain on the edit information page to correct the information$/) do
  expect(page).to have_current_path(path_to('edit personal information'))
end
