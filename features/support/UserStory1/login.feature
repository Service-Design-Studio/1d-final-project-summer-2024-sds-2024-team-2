Feature: Login to User Account
  As an undocumented individual or authorized NGO/UNHCR personnel
  I want to log in to my user account on the app
  So that I can access the web app's services and be redirected to the account dashboard page

  Scenario: Successfully log in to the account
    Given I am on the login page
    When I fill in the "username" field with "validUser"
    And I fill in the "password" field with "validPassword"
    And I press the "Log in" button
    Then I will be logged in successfully
    And I will be redirected to the account dashboard page
    And I will see a welcome message "Welcome validUser!"

  Scenario: Failed login due to missing required field(s)
    Given I am on the login page
    When I leave the "username" field empty
    And I fill in the "password" field with "validPassword"
    And I press the "Log in" button
    Then I will see an error message "Username is required"
    And I will remain on the login page

  Scenario: Failed login due to incorrect credentials
    Given I am on the login page
    When I fill in the "username" field with "incorrectUser"
    And I fill in the "password" field with "validPassword"
    And I press the "Log in" button
    Then I will see an error message "Incorrect username or password"
    And I will remain on the login page
