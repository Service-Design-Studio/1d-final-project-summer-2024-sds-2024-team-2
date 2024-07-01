When(/^I fill in the "(.*?)" field with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I press the "(.*?)" button$/) do |button_name|
  click_button button_name
end

Then(/^I will be logged in successfully$/) do
  expect(page).to have_content('Welcome')
end

Then(/^I will be redirected to the "(.*?)" page$/) do |page_name|
  expect(page).to have_current_path(path_to(page_name))
end

Then(/^I will see a welcome message "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I will see an error message "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I will remain on the "(.*?)" page$/) do |page_name|
  expect(page).to have_current_path(path_to(page_name))
end
