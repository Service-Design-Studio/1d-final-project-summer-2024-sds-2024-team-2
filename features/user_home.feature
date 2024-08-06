Feature: User Home Page

Background:
    Given I am now on the user particulars home page as a verified user

Scenario: Generating a 2FA passcode
    When I click on the "Generate 2FA Passcode:" button
    Then I should see a 2FA passcode generated

Scenario: Navigating to the Documents page
    When I press on the "Documents" button
    Then I should be redirected to the "Documents" page

Scenario: Navigating to the Activity History page
    When I press on the "Activity History" button
    Then I should be redirected to the "Activity History" page
    And I should see a list of my recent activities
    