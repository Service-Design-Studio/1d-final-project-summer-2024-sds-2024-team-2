Feature: User Login
  As a registered user with an existing account,
  I want to be able to enter my login details
  So that I can log in to my account

Background:
  Given that a User account by the Username of "user1", Email of "user1@mail.com", Phone Number of "90000001" exist
  And I am on the "Login" page

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