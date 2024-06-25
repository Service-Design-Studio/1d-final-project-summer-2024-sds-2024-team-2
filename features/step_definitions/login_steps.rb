Given('I am on the login page') do
  visit new_user_session_path
end

When('I fill in the username field with {string}') do |username|
  fill_in 'Username', with: username
end

When('I fill in the password field with {string}') do |password|
  fill_in 'Password', with: password
end

When('I press the login button') do
  click_button 'Log in'
end

Then('I will be logged in successfully') do
  expect(page).to have_content('Welcome')
end

Then('I will be redirected to the account dashboard page') do
  expect(page).to have_current_path(user_dashboard_path)
end

Then('I will see a welcome message {string}') do |message|
  expect(page).to have_content(message)
end

Then('I will see an error message {string}') do |message|
  expect(page).to have_content(message)
end

Then('I will remain on the login page') do
  expect(page).to have_current_path(new_user_session_path)
end
