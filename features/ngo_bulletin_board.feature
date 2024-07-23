Feature: Access and interact with common bulletin board
  As a non-governmental organization(NGO) personnel
  I want to access the common bulletin board and have a space to broadcast messages
  So that I can view and interact with posts from other NGOs and upload my own NGO's posts

Background:
  Given I am already on the NGO "Gebirah" page

Scenario: Broadcasting a message to the common bulletin board
  When I press the "+" button
  Then I should be redirected to the "Add Posts" page
  And I should see a form to enter my message and insert pictures
  When I fill in the form and press the "Post" button
  Then my message should be posted on the common bulletin board
  And I should see a confirmation message "Posted"