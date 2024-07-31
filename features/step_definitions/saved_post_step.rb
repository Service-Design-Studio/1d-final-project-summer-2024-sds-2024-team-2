Given('an event titled {string} with an ID of {int} exists') do |title, id|
  bulletin = Bulletin.find_by(id:)
  expect(bulletin).not_to be_nil
  expect(bulletin.title).to eq(title)
  expect(bulletin.date).to eq(DateTime.new(2024, 7, 1))
  expect(bulletin.location).to eq('Singapore')
  expect(bulletin.description).to eq('Welfare giveaway event!')
  expect(bulletin.ngo_name).to eq('Gebirah')
  expect(bulletin.saved).to be_falsey
end

And(/^there are no saved posts$/) do
  puts "SavedPost count before test: #{SavedPost.count}"
  # Your test code here
  SavedPost.first.delete if SavedPost.first.present?
  puts "SavedPost count after test: #{SavedPost.count}"
end

When(/^I press on the unfilled bookmark icon on the "([^"]+)", ID: "([^"]+)" event card$/) do |title, id|
  # Locate the event card with the specified title and ID
  event_card = find(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']")

  # Within this event card, find the <i> element that is a direct child of the <a> element with the onclick attribute set to toggleSavePost(this)
  bookmark_icon = event_card.find('a > i.bookmarker')
  # Verify that the <i> element has the class 'bi-bookmark'
  expect(bookmark_icon[:class]).to include('bi-bookmark')

  # Simulate a click on this <i> element
  step "I press the \"toggle #{title} #{id}\" button"
end

When(/^I press on the filled bookmark icon on the "([^"]+)", ID: "([^"]+)" event card$/) do |title, id|
  # Locate the event card with the specified title and ID
  event_card = find(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']")

  # Within this event card, find the <i> element that is a direct child of the <a> element with the onclick attribute set to toggleSavePost(this)
  bookmark_icon = event_card.find('a > i.bookmarker')

  # Verify that the <i> element has the class 'bi-bookmark'
  expect(bookmark_icon[:class]).to include('bi-bookmark-fill')

  # Simulate a click on this <i> element
  step "I press the \"toggle #{title} #{id}\" button"
end

Then(/^the bookmark icon for the "([^"]+)", ID: "([^"]+)" event card is filled$/) do |title, id|
  # Locate the event card with the specified title and ID
  event_card = find(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']")
  # Within this event card, find the <i> element that is a direct child of the <a> element with the onclick attribute set to toggleSavePost(this)
  bookmark_icon = event_card.find("a[onclick='toggleSavePost(this)'] > i")
  # Verify that the <i> element has the class 'bi-bookmark-fill'
  expect(bookmark_icon[:class]).to include('bi-bookmark-fill')
end

Then(/^the "([^"]+)", ID: "([^"]+)" event card bookmark icon should become unfilled$/) do |title, id|
  # Locate the event card with the specified title and ID
  event_card = find(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']")
  # Within this event card, find the <i> element that is a direct child of the <a> element with the onclick attribute set to toggleSavePost(this)
  bookmark_icon = event_card.find('a > i.bookmarker')
  # Verify that the <i> element has the class 'bi-bookmark-fill'
  expect(bookmark_icon[:class]).to include('bi-bookmark')
end

And(/^the "([^"]+)", ID: "([^"]+)" event card should be present$/) do |title, id|
  # Locate the event card with the specified title and ID
  event_card = find(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']", visible: true)
  # Verify that the event card is present
  expect(event_card).to be_present
end

And(/^the "([^"]+)", ID: "([^"]+)" event card should not be present$/) do |title, id|
  # Locate the event card with the specified title and ID
  expect(page).not_to have_css(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']", visible: true)
end

Given(/^I have saved a "([^"]+)", ID: "([^"]+)" event card$/) do |title, id|
  # Press on the unfilled bookmark icon to save the event
  step "I press on the unfilled bookmark icon on the \"#{title}\", ID: \"#{id}\" event card"
  # Verify that the bookmark icon is filled
  step "the bookmark icon for the \"#{title}\", ID: \"#{id}\" event card is filled"
end
