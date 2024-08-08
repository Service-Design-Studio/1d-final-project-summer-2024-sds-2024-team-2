Given(/^the Digital ID is showing my information$/) do
  expect(page).to have_selector('div.card-1#mainCard')
end

When(/^I press on the "QR code" icon button$/) do
  find('img#qrCode').click
end

Then(/^I should see a unique QR code$/) do
  expect(page).to have_selector('img.qr-code[alt="Default image"][style="width: 190px; height: 190px;"]')
end

When(/^I press on the "card" icon button$/) do
  find('img#qrCode').click
end

Given(/^I should see a unique my information$/) do
  expect(page).to have_selector('div.card-1#mainCard')
end
