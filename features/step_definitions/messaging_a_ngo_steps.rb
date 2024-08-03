Given('I am already on the NGO {string} page') do |ngo_name| do
  @ngo_user = NGOUser.find_by(name: ngo_name)
  raise "NGO not found" unless @ngo_user
  @message = Message.find_by(ngo_user_id: @ngo_user.id)
end

And('{string} send a message {string} to {string}') do |user,message,ngo_name| do
  @user = User.find_by(username: user)
  raise "NGO not found" unless @ngo_user
  @user.send_message(@ngo_user, message)
end

When(/^I press on the "Inbox" button$/) do
  # Find the Inbox link and click it
  find_link('Inbox').click
end

Then(/^I should be redirected to the "Inbox" page$/) do
  # Ensure the current path is the Inbox page path
  expect(page).to have_current_path('/inbox', url: true)
end

And('I should see a list of past messages recieved') do |message, user| do
  expect(page).to have_css('.contact-history ul li', minimum: 1)
end