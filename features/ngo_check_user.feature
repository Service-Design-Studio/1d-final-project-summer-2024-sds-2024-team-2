Feature: Check EnableID user
  As a non-governmental organization(NGO) personnel
  I want to check an EnableID user's Unique ID and 2FA code
  So that I can proceed to verify their EnableID card

Background:
  Given I am already on the NGO 'Gebirah' page

Scenario: Unique ID and 2FA Code exists
  When I press on "Verify User" button
  And I fill in the following valid fields
  | Field                     | Value             |
  | Unique ID                 | 1055290           |
  | 2FA Code                  | 606833            |
  And I press the "Check" button
  Then I should be redirected to the User Verification page under "Gebirah"

Scenario: Unique ID does not exist
  When I press on the "Verify User" button
  And I fill in the following fields
  | Field                     | Value             |
  | Unique ID                 | 0000000           |
  | 2FA Code                  | 606833            |
  And I press the "Check" button
  Then I should see the message "User not found. Please check your Unique ID and 2FA Code."

Scenario: 2FA Code does not exist
  When I press on the "Verify User" button
  And I fill in the following fields
  | Field                     | Value             |
  | Unique ID                 | 1055290           |
  | 2FA Code                  | 000000            |
  And I press the "Check" button
  Then I should see the message "User not found. Please check your Unique ID and 2FA Code."


