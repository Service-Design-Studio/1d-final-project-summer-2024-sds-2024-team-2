Given(/^I am on the (.+) page$/) do |page_name|
  visit path_to(page_name)
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
