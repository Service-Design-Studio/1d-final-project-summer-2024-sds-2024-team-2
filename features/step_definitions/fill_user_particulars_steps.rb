# Step definitions for filling in user particulars form

Then(/^I should see the following fields:$/) do |table|
  table.rows.each do |row|
    field = row[0]
    expect(page).to have_field(field)
  end
end

Then(/^the fields should be empty$/) do
  expect(page).to have_field('Full Name', with: '')
  expect(page).to have_field('Phone Number', with: '')
  expect(page).to have_field('Secondary Phone Number', with: '')
  expect(page).to have_select('Country of Origin', selected: nil)
  expect(page).to have_select('Ethnicity', selected: nil)
  expect(page).to have_select('Religion', selected: nil)
  expect(page).to have_select('Gender', selected: nil)
  expect(page).to have_field('Date of Birth', with: '')
  expect(page).to have_field('Date of Arrival in Malaysia', with: '')
end

Given(/^I enter the following particulars:$/) do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
end

Given(/^I do not enter a "(.*?)"$/) do |field|
  fill_in field, with: ''
end

Given(/^I do not select a "(.*?)"$/) do |field|
  select '', from: field
end

Then(/^I will be prompted to fill in the "(.*?)" field$/) do |field|
  expect(page).to have_content("#{field} can't be blank")
end

Then(/^I should remain on the "(.*?)" page$/) do |page_name|
  expect(page).to have_current_path(path_to(page_name))
end

When(/^I enter "(.*?)" into the "(.*?)" field$/) do |value, field|
  fill_in field, with: value
end

When(/^I select "(.*?)" from the "(.*?)" dropdown$/) do |value, field|
  select value, from: field
end

Then(/^I should see the filled-in details:$/) do |table|
  table.rows_hash.each do |field, value|
    expect(page).to have_content(value)
  end
end
