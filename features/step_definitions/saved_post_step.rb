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

When(/^I press on the unfilled bookmark icon on the "([^"]+)", ID: "([^"]+)" event card$/) do |title, id|
  # Locate the event card with the specified title and ID
  event_card = find(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']")

  # Within this event card, find the <i> element that is a direct child of the <a> element with the onclick attribute set to toggleSavePost(this)
  bookmark_icon = event_card.find("a[onclick='toggleSavePost(this)'] > i.bi-bookmark")
  # Verify that the <i> element has the class 'bi-bookmark'
  expect(bookmark_icon[:class]).to include('bi-bookmark')

  # Simulate a click on this <i> element
  bookmark_icon.click
end

Then(/^the bookmark icon for the "([^"]+)", ID: "([^"]+)" event card is filled$/) do |title, id|
  # Locate the event card with the specified title and ID
  event_card = find(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']")

  # Within this event card, find the <i> element that is a direct child of the <a> element with the onclick attribute set to toggleSavePost(this)
  bookmark_icon = event_card.find("a[onclick='toggleSavePost(this)'] > i")

  # Verify that the <i> element has the class 'bi-bookmark-fill'
  expect(bookmark_icon[:class]).to include('bi-bookmark-fill')
end

And(/^the "([^"]+)", ID: "([^"]+)" event card should be present$/) do |title, id|
  # Locate the event card with the specified title and ID
  @saved_post = SavedPost.find_by(bulletin_id: id)
  event_card = find(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']", visible: true)
  # Verify that the event card is present
  expect(event_card).to be_present
end
