# This is the step definition for navigating to a specific page. Since you want to remove this common step, we'll assume the navigation is handled elsewhere.

Then(/^I should see the text "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
