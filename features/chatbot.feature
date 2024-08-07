Feature: AI-powered chatbot
  As an EnableID user
  I want to have convenient 24/7 access to customer service help and support
  So that I can easily retrieve the information I seek and need

Background:
    Given I am now on the user particulars home page as a verified user

Scenario: Activating the Chat-bot from laptop screen
  Given I am using this on a laptop
  When I press the "Talk to your AI assistant, Freddy!" button
  Then I should see the chat display appear
  And I should see "Hi! Let me know how I can help you!"

Scenario: Activating the Chat-bot from smaller mobile device
  Given I am using this on a iPhone SE
  When I press on the speech bubble icon button
  Then I should see the chat display appear
  And I should see "Hi! Let me know how I can help you!"

Scenario: Bot introducing itself and functionalities
  Given I opened up the chat display
  When I type in "What could you help me with?
  And I press the submit logo button
  Then I should see "Freddy" from the bot's response
  And I should see "EnableID" from the bot's response