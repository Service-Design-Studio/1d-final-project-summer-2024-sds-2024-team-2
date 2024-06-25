Given('I am on the signup page') do
  visit new_user_registration_path
end

When('I fill in the following:') do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
end

When('I press the register button') do
  click_button 'Sign up'
end

Then('I will see a confirmation message {string}') do |message|
  expect(page).to have_content(message)
end

Then('I will be redirected to the login page') do
  expect(page).to have_current_path(new_user_session_path)
end

Then('I will see an error message {string}') do |message|
  expect(page).to have_content(message)
end

Then('I will remain on the signup page') do
  expect(page).to have_current_path(user_registration_path)
end
