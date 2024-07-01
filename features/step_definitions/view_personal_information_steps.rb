# View Personal Information Step Definitions

# Step definition for logging in successfully
Given(/^I am logged in successfully$/) do
  @user = User.create!(username: 'testuser', email: 'testuser@example.com', password: 'password123')
  visit path_to('login')
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
  expect(page).to have_content('Welcome')
end

# Step definition for navigating to a specific page
When(/^I navigate to the personal information page$/) do
  visit path_to('personal information')
end

# Step definition for retrieving and displaying personal details
Then(/^the system retrieves my personal details$/) do
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

Then(/^the system displays my personal details including full name, date of birth, country of origin, ethnicity, religion, gender, date of arrival in Malaysia, and uploaded documents$/) do
  expect(page).to have_content(@user.full_name)
  expect(page).to have_content(@user.date_of_birth)
  expect(page).to have_content(@user.country_of_origin)
  expect(page).to have_content(@user.ethnicity)
  expect(page).to have_content(@user.religion)
  expect(page).to have_content(@user.gender)
  expect(page).to have_content(@user.date_of_arrival_in_malaysia)
  @user.uploaded_documents.each do |document|
    expect(page).to have_content(document.file_name)
  end
end

Then(/^the system displays my status as "(.*?)"$/) do |status|
  expect(page).to have_content(status)
end

# Step definition for empty personal details
Given(/^my personal details are empty$/) do
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

Then(/^the system displays empty fields$/) do
  expect(page).to have_field('Full name', with: '')
  expect(page).to have_field('Date of birth', with: '')
  expect(page).to have_field('Country of origin', with: '')
  expect(page).to have_field('Ethnicity', with: '')
  expect(page).to have_field('Religion', with: '')
  expect(page).to have_field('Gender', with: '')
  expect(page).to have_field('Date of arrival in Malaysia', with: '')
end

Then(/^the system shows a notice prompting me to fill in my information$/) do
  expect(page).to have_content('Please fill in your information')
end

# Step definition for viewing uploaded documents
When(/^I click on the button beside an uploaded document$/) do
  click_button 'View Document'
end

Then(/^the system retrieves the list of uploaded documents$/) do
  @documents = @user.uploaded_documents
end

Then(/^the system displays the list of uploaded documents with a button beside each document$/) do
  @documents.each do |document|
    expect(page).to have_content(document.file_name)
    expect(page).to have_button('View Document')
  end
end

Then(/^the system verifies the existence of the document$/) do
  @documents.each do |document|
    expect(File.exist?(document.file_path)).to be_truthy
  end
end

Then(/^the system displays the document to me$/) do
  @documents.each do |document|
    expect(page).to have_content(document.content)
  end
end
