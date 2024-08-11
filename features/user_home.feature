Feature: User Home Page

Background:
    Given I am now on the user particulars home page as a verified user

Scenario: Generating a 2FA passcode
    When I click on the "Generate 2FA Passcode:" button
    Then I should see a 2FA passcode generated
    