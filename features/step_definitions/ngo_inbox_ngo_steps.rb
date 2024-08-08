Given('I am already on the NGO "([^"]*)" page') do |ngo_name|
  visit ngo_path(ngo_name) # Assuming you have a route helper for NGO pages
end

Given(/^"([^"]*)" send a message "([^"]*)" to "([^"]*)"$/) do |user_name,message, ngo_name|
  user = User.find_by(username: user_name)
  ngo = NgoUser.find_by(name: ngo_name)

  if user.nil? || ngo.nil?
    raise "User or NGO not found."
  end

  unless user.send_message(user.id,ngo.id, message)
    raise "Failed to send message."
  end
end

When('I press on the {string} button') do |button_name|
  find('a', text: button_name).click
end

Then(/^I should be redirected to the NGO "([^"]*)" "([^"]*)" page$/) do |ngo_name, ngo_path|
  @ngo_user = NgoUser.find_by(name: ngo_name)
  expect(@ngo_user).not_to be_nil, "NgoUser with name #{ngo_name} not found."

  expected_path = "/ngo_users/#{@ngo_user.id}/#{ngo_path}"
  expect(current_path).to eq(expected_path),
                          "Expected to be redirected to #{expected_path} but was at #{current_path} instead."
end

Then('I should see a list of past messages received') do
  expect(page).to have_css('.contact-history') # Adjust the selector as needed
end

Given('I am on the NGO {string} {string} page') do |ngo_name, page|
  ngo = NgoUser.find_by(name: ngo_name) # Assuming you have a model Ngo where you can find the NGO by name
  raise "NGO not found" unless ngo

  case page
  when "inbox"
    visit inbox_ngo_user_path(ngo.id) # Make sure this matches the named route helper
  else
    raise "Page not defined"
  end
end

When('I click on the first message') do
  first('li[data-full-name]').click # Adjust the selector as needed
end

Then('I should see the details of the first message in the details panel') do
  expected_message = "Message:\nHi, I need help regarding Education, can you contact me at your as soon as possible, preferably by email".strip
  expect(find('#name')).to have_content('Name: Rohingya Aung')
  expect(find('#idNumber')).to have_content('ID Number: 1055290')
  expect(find('#contactNo')).to have_content('Contact Number: +60 111-222-3333')
  expect(find('#email')).to have_content('Email: user1@mail.com')
  actual_message = find('#message').text.strip
  expect(actual_message).to eq(expected_message)
end
