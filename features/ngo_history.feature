Feature: View interaction history and add internal comments
  As a non-governmental organization(NGO) personnel
  I want to view the history of interactions with undocumented users and add internal comments
  So that I can keep track of interactions and share notes with other NGOs

Scenario: Viewing interaction history
  Given I am on the NGO "Gebirah" page
  When I press the "History" button
  Then I should be redirected to the interaction history page
  And I should see a list of users I have interacted with
  And I should be able to click on a user to view their details

Scenario: Adding an internal comment
  Given I am viewing a user's details
  When I press the "Add Comment" button
  Then I should see a form to enter an internal comment
  When I fill in the form and press the "Submit" button
  Then I should see a confirmation message "Comment added successfully"

Scenario: Viewing user's internal comments
  Given I am viewing a user's details
  When I press the "View comments" button
  Then I should see a list of internal comments by other NGOs for that user
