Then('I should see the following list of errors:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.raw.flatten.each do |error_message|
    expect(page).to have_content(error_message)
  end
end
