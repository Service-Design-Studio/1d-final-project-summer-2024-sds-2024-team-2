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
  # event_card = find(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']")

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
  using_wait_time(5) do
    # Locate the event card with the specified title and ID
    event_card = find(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']")
    # Within this event card, find the <i> element that is a direct child of the <a> element with the onclick attribute set to toggleSavePost(this)
    bookmark_icon = event_card.find("a[onclick='toggleSavePost(this)'] > i")
    # Verify that the <i> element has the class 'bi-bookmark-fill'
    expect(bookmark_icon[:class]).to include('bi-bookmark-fill')
  end
end

When(/^I press on the message icon on the "([^"]+)", ID: "([^"]+)" event card$/) do |title, id|
  # Locate the event card with the specified title and ID
  # event_card = find(".event-card[data-title='#{title}'][data-bulletin-id='#{id}']")
  # Simulate a click on this <i> element
  step "I press the \"sender #{title} #{id}\" button"
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

When('I press on the event card {string}, ID: {string}') do |event_name, event_id|
  # Locate the event card by its title and ID
  event_card = find(:css, "div.event-card[data-title='#{event_name}'][data-bulletin-id='#{event_id}']")

  # Click on the event card
  event_card.click
end

Then('I should open up a modal with {string} as the header') do |expected_header|
  # Wait for the modal to be visible
  expect(page).to have_css('#eventCards', visible: true)

  # Verify the modal header text
  modal_header = find('#eventCards .modal-header #modal-title').text
  expect(modal_header).to eq(expected_header)
end

And('I should see all the other details of the event card in the modal') do
  # Wait for the modal to be visible
  expect(page).to have_css('#eventCards', visible: true)

  # Verify the modal header text
  expect(page).to have_css('#eventCards .modal-header #modal-title', text: 'Gebirah Aid Giveaway')

  # Verify the modal body details
  expect(page).to have_css('#eventCards .modal-body #modal-ngoname', text: 'Gebirah')
  expect(page).to have_css('#eventCards .modal-body #modal-description', text: 'Description: Welfare giveaway event!')
  expect(page).to have_css('#eventCards .modal-body #modal-date', text: 'Date: 01 July 2024')
  expect(page).to have_css('#eventCards .modal-body #modal-location', text: 'Location: Singapore')
  expect(page).to have_css('#eventCards .modal-body #modal-id', text: 'Event ID: 1')
end

And('I should see a "Send a Message" button') do
  # Wait for the modal to be visible
  expect(page).to have_css('#eventCards', visible: true)

  # Verify the presence of the "Send a Message" button
  expect(page).to have_css('#modal-send-btn', text: 'Send a message')
end

And('I should see a "Add to Saved" button') do
  # Wait for the modal to be visible
  expect(page).to have_css('#eventCards', visible: true)

  # Verify the presence of the "Add to Saved" button
  expect(page).to have_css('#modal-saved-btn', text: 'Add to Saved')
end

And('I should see a "Saved" button') do
  # Wait for the modal to be visible
  expect(page).to have_css('#eventCards', visible: true)

  # Verify the presence of the "Add to Saved" button
  expect(page).to have_css('#modal-saved-btn', text: 'Saved')
end

And('the bookmark icon on the "Saved" button should be filled') do
  # Wait for the modal to be visible
  expect(page).to have_css('#modal-saved-btn', visible: true)
  bookmark_icon = page.find('#modal-saved-btn > i')

  # Verify that the <i> element has the class 'bi-bookmark-fill'
  expect(bookmark_icon[:class]).to include('bi-bookmark-fill')
end

Given('I have opened up the modal on the event card "Gebirah Aid Giveaway", ID: "1"') do
  step 'I press on the event card "Gebirah Aid Giveaway", ID: "1"'
end

Given('I close the modal') do
  # Wait for the modal to be visible
  expect(page).to have_css('.modal-dialog', visible: true)

  # Click the close button within the modal
  find('.btn-close').click

  # Wait for the modal to be hidden
  expect(page).to have_no_css('.modal-dialog', visible: true)
end
