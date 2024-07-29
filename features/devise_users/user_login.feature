Feature: User Login
  As a registered user with an existing account,
  I want to be able to enter my login details
  So that I can log in to my account

Background:
  Given that a User account by the Username of "user1", Email of "user1@mail.com", Phone Number of "90000001" exist
  And I am on the "Login" page

Scenario: Successful Login with Phone Number
  Given I fill in the following fields
    | Field             | Value       |
    | Log in EnableID      | 90000001    |
    | Password          | password1   |
  And I press the "Log in" button
  Then I should enter the "Home" page

Scenario: Successful Login with Email
  Given I fill in the following fields
    | Field             | Value       |
    | Log in EnableID             | user1@mail.com   |
    | Password          | password1   |
  And I press the "Log in" button
  Then I should enter the "Home" page

Scenario: Successful Login with Username
  Given I fill in the following fields
    | Field             | Value       |
    | Log in EnableID          | user1   |
    | Password          | password1   |
  And I press the "Log in" button
  Then I should enter the "Home" page

Scenario: Wrong Password
  Given I fill in the following fields
    | Field             | Value       |
    | Log in EnableID      | user1  |
    | Password          | password   |
  And I press the "Log in" button
  Then I should see "Invalid Login or password."

Scenario: Phone Number Not Registered
  Given I fill in the following fields
    | Field             | Value       |
    | Log in EnableID      | 98765432   |
    | Password          | password   |
  And I press the "Log in" button
  Then I should see "Invalid Login or password."

Scenario: Blank Log in
  Given I fill in the following fields
    | Field             | Value       |
    | Log in EnableID      |    |
    | Password          | password   |
  And I press the "Log in" button
  Then I should stay on the "Login" page

Scenario: Blank Password
  Given I fill in the following fields
    | Field             | Value       |
    | Log in EnableID      | 98765432    |
    | Password          |             |
  And I press the "Log in" button
  Then I should stay on the "Login" page