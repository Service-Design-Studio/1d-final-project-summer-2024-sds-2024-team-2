Given('I am using this on a laptop') do
  # Resize the browser window to a typical laptop size
  page.driver.browser.manage.window.resize_to(1366, 768)
end

Given('I am using this on a iPhone SE') do
  # Resize the browser window to a typical laptop size
  page.driver.browser.manage.window.resize_to(375, 667)
end

Then('I should see the chat display appear') do
  # Check if the chat display element is visible
  expect(page).to have_selector('.chat-display', visible: true, wait: 20)
end

Given('I opened up the chat display') do
  # Resize the browser window to a typical laptop size
  page.driver.browser.manage.window.resize_to(1366, 768)
  step 'I press the "Talk to your AI assistant, Freddy!" button'
  # Ensure the chat display is visible
  expect(page).to have_selector('.chat-display', visible: true)
end

When('I press on the speech bubble icon button') do
  # Find the div with the clasIs 'chat-button small-chat-button' and id 'smallchatbutton' and click it
  find('div.chat-button.small-chat-button#smallchatbutton').click
end

When('I type in "What could you help me with?') do
  # Find the textarea with the id 'user-input' and input the specified text
  fill_in 'user-input', with: 'What could you help me with?'
end

And('I press the submit logo button') do
  # Find the button with the id 'sendButton' and click it
  find('button#sendButton').click
end

Then('I should see {string} from the bot\'s response') do |expected_text|
  puts expected_text
  # Find the div with the id 'chat-box' and check if it contains the expected text
  within('#chat-box') do
    expect(page).to have_content(expected_text)
  end
end
