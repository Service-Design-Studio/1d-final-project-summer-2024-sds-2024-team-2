When('I fill the message with {string}') do |message|
  # Locate the message textarea field
  message_field = find('#message-text')

  # Fill the textarea field with the provided message
  message_field.set(message)
end
