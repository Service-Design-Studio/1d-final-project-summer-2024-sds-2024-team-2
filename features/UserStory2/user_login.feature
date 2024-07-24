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
  Then I should be redirected to the "Home" page

Scenario: Successful Login with Email
  Given I fill in the following fields
    | Field             | Value       |
    | Log in EnableID             | user1@mail.com   |
    | Password          | password1   |
  And I press the "Log in" button
  Then I should be redirected to the "Home" page

Scenario: Successful Login with Username
  Given I fill in the following fields
    | Field             | Value       |
    | Log in EnableID          | user1   |
    | Password          | password1   |
  And I press the "Log in" button
  Then I should be redirected to the "Home" page

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
  Then I should see "Please fill in this field."

Scenario: Blank Password
  Given I fill in the following fields
    | Field             | Value       |
    | Log in EnableID      | 98765432    |
    | Password          |             |
  And I press the "Log in" button
  Then I should see "Please fill in this field."

Scenario: Forgot Password
  Given I am on the "Login" page
  When I click "Forgot password?"
  Then I should be redirected to the "Reset Password" page
  And I should see a form to enter my phone number or email

Scenario: Account Lockout After Multiple Failed Attempts
  Given I have registered with the following details:
    | Phone Number      | 98765432
    | Password          | correctpassword
  When I enter the password incorrectly three times:
    | Phone Number      | 98765432
    | Password          | wrongpassword
  Then I should see an error message "Your account is locked due to multiple failed login attempts. Please try again later."
  And I should see the empty login page

Scenario: Successful Login After Account Lockout Period
  Given my account is locked due to multiple failed login attempts
  When I wait for the lockout period to end
  And I enter the following correct password:
    | Phone Number      | 98765432
    | Password          | correctpassword
  And I press the "Log in" button
  Then I should be redirected to the "Home" page