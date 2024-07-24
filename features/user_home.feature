Feature: User Home Page

Background:
    Given I am now on the user particulars home page as a verified user

Scenario: Generating a 2FA passcode
    Given I am now on the my user particulars home page
    When I click on the "Generate 2FA passcode" button
    Then I should see a 2FA passcode generated

Scenario: Navigating to the Documents page
    Given I am now on the my user particulars home page
    When I press on the "Documents" button
    Then I should be redirected to the "Documents" page

Scenario: Navigating to the Activity History page
    Given I am now on the my user particulars home page
    When I press on the "Activity History" button
    Then I should be redirected to the "Activity History" page
    And I should see a list of my recent activities
    And each activity should display the date, time, and description
    And the activities should be displayed with the latest activity at the top

Scenario: Navigating to the Edit Particulars page
    Given I am now on the my user particulars home page
    When I press on the "edit icon" button
    Then I should be redirected to the "Edit Particulars" page
    And I should see the user particulars I had previosly entered