Feature: User Login
  As a registered user with an existing account,
  I want to be able to enter my login details
  So that I can log in to my account

Scenario: Successful Login with Phone Number
  Given I enter the following details on the phone number login page:
    | Phone Number      | 98765432
    | Password          | password123
  And I press "Login"
  Then I should be redirected to the home page

Scenario: Successful Login with Email
  Given I enter the following details on the email login page:
    | Email             | brendan@gmail.com
    | Password          | password123
  And I press "Login"
  Then I should be redirected to the home page

Scenario: Successful Login with Username
  Given I enter the following details on the username login page:
    | Username          | brendannnn
    | Password          | password123
  And I press "Login"
  Then I should be redirected to the home page

Scenario: Wrong Password
  Given I am on the login page
  When I enter the following details:
    | Phone Number      | 98765432
    | Password          | password
  And I press "Login"
  Then I should see an error message "Invalid phone number or password"
  And I should see the empty login page again

Scenario: Phone Number Not Registered
  Given I am on the login page
  When I enter the following details:
    | Phone Number      | 98765432
    | Password          | password
  And I press "Login"
  Then I should see an error message "Invalid phone number or password"
  And I should see the empty login page again

Scenario: Blank Phone Number
  Given I am on the login page
  When I enter the following details:
    | Phone Number      | 
    | Password          | password
  And I press "Login"
  Then I should see an error message "Phone number cannot be blank"

Scenario: Blank Password
  Given I am on the login page
  When I enter the following details:
    | Phone Number      | 98765432
    | Password          | 
  And I press "Login"
  Then I should see an error message "Password cannot be blank"

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
  And I press "Login"
  Then I should be redirected to the home page