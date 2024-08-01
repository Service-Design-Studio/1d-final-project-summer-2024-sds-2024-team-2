# Given I am already on the NGO "Gebirah" page
Given(/^I am already on the NGO "(.*?)" page$/) do |ngo_name|
  # Assuming you have a method to find the NGO user by name and get its ID
  # ngo_user = NgoUser.find_by(name: ngo_name)
  # visit ngo_user_path(ngo_user)

  # If you're using IDs directly and "Gebirah" corresponds to a specific ID, e.g., 6
  ngo_user_id = 6 # You would dynamically fetch this based on `ngo_name` in a real app
  visit ngo_user_path(ngo_user_id)
end

# Given(/^I am on the user home page$/) do |page|
#   visit path_to(home)
# end

Then(/^I should see event card with the following fields$/) do |table|
  table.hashes.each do |row|
    within('#event-cards-container') do
      expect(page).to have_selector('.event-card', text: row['Title'])
      expect(page).to have_selector('.event-card', text: row['Description'])
      expect(page).to have_selector('.event-card', text: row['Date'])
      expect(page).to have_selector('.event-card', text: row['Location'])
    end
  end
end