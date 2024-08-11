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

