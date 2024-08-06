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
  expect(page).to have_selector('.chat-display', visible: true)
end
