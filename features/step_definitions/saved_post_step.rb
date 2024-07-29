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
