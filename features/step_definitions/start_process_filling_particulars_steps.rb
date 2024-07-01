# Step definitions for starting the process of filling user particulars form

When(/^I press the "(.*?)" button$/) do |button_name|
  click_button button_name
end

Then(/^I should be redirected to the "([^"]*)" page$/) do |page_name|
  expect(page).to have_current_path(path_to(page_name))
end

Then(/^I should see the text "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
