Given(/^I am on the (.+) page$/) do |page_name|
  visit path_to(page_name)
end

When(/^I press "(.*?)"$/) do |button_name|
  click_button button_name
end

Then(/^I should be redirected to the (.+) page$/) do |page_name|
  expect(page).to have_current_path(path_to(page_name))
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
