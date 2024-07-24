Feature: Check EnableID user
  As a non-governmental organization(NGO) personnel
  I want to check an EnableID user's Unique ID and 2FA code
  So that I can proceed to verify their EnableID card

Background:
  Given I am already on the NGO "Gebirah" page

Scenario: Unique ID does not exist
  When I press the "Verify User" button
  Then I should see "Please enter details of individual you would like to verify"
  Given I fill in the following fields
  | Field                     | Value             |
  | Unique ID                 | 0000000           |
  | 2FA Code                  | 606833            |
  And I press the "Check" button
  Then I should see "User not found. Please check your Unique ID and 2FA Code."

Scenario: 2FA Code does not exist
  When I press the "Verify User" button
  Then I should see "Please enter details of individual you would like to verify"
  Given I fill in the following fields
  | Field                     | Value             |
  | Unique ID                 | 1055290           |
  | 2FA Code                  | 000000            |
  And I press the "Check" button
  Then I should see "User not found. Please check your Unique ID and 2FA Code."


