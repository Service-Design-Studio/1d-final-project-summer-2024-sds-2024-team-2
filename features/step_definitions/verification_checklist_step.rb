
When(/^I click all the boxes in the verification checklist$/) do
  # Wait for the first checkbox to ensure the page is loaded
  expect(page).to have_css('.inputGroup', visible: true)

  (1..5).each do |i|
    # Find and click the label for each checkbox
    find("label[for='option#{i}']").click
  end
end

Then(/^ I should be redirected to the NGO "([^"]*)" page$/) do
  expect(current_path).to eq('/path/to/ngo_users/6') # Adjust the path as necessary
  expect(page).to have_content("NGO Gebirah")
end

Then(/^I should see a success message stating "(.*)"$/ ) do |success_message|
  expect(page).to have_content(success_message)
end


When(/^I did not click all the boxes in the verification checklist$/) do
  leave_verification_checklist_incomplete # Implement this method to not check all boxes
end

# Step definition for verifying the "Verify" button is not clickable
Then("I am not able to press the {string} button") do |button_text|
  # This step assumes the button is disabled when the checklist is incomplete
  # Adjust the selector as necessary for your application
  expect(page).to have_button(button_text, disabled: true)
end


def leave_verification_checklist_incomplete
  # Assuming you have a specific class or identifier for your checkboxes, click only some of them
  # This is a simplistic example; adjust according to your actual HTML structure
  (1..3).each do |i| # Assuming there are 5 checkboxes and you're only clicking the first 3
    find("label[for='option#{i}']").click
  end
end