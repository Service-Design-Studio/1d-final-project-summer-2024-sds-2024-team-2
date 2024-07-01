# Step definitions for confirming and viewing particulars

Given(/^I entered the following particulars:$/) do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
end

Then(/^I should see the filled-in details:$/) do |table|
  table.rows_hash.each do |field, value|
    expect(page).to have_content(value)
  end
end

When(/^I press "(.*?)"$/) do |button_name|
  click_button button_name
end

Then(/^I should see the following fields in the Digital ID:$/) do |table|
  table.rows_hash.each do |field, value|
    expect(page).to have_content(value)
  end
end

Then(/^I will be redirected to the "(.*?)" page$/) do |page_name|
  expect(page).to have_current_path(path_to(page_name))
end

Then(/^I should see the previously filled-in details:$/) do |table|
  table.rows_hash.each do |field, value|
    expect(page).to have_field(field, with: value)
  end
end
