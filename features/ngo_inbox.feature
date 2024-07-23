Feature: Manage inbox
  As a non-governmental organization(NGO) personnel
  I want to access my inbox
  So that I can view and manage messages from other NGOs or undocumented users

Scenario: Viewing inbox messages from undocumented users
  Given I am on the NGO "Gebirah" page
  When I press the "Inbox" button
  Then I should be redirected to my NGO's inbox
  And I should see a list of messages

Scenario: Replying inbox messages from undocumented users or other NGOs
  Given I am on my NGO's inbox page
  When I press the "Reply" button
  Then I should see an empty text box
  When I enter a reply and press "Submit"
  Then I should see "Message sent"