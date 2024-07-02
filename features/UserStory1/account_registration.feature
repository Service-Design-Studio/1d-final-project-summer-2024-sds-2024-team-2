Feature: Account registration
  As an undocumented individual
  I want to create a user account on the app
  So that I can log in to the app

  Scenario: Successfully signup for an account
    Given I am on the signup page
    When I fill in the following:
      | Username        | testuser     |
      | Email           | test@example.com |
      | Phone number    | 1234567890   |
      | Password        | password     |
      | Confirm Password| password     |
    And I press the "Sign up" button
    Then I will see a confirmation message "Registration Successful"
    And I will be redirected to the login page

  Scenario: Failed registration due to missing required field(s)
    Given I am on the signup page
    When I fill in the following:
      | Email           | test@example.com |
      | Phone number    | 1234567890   |
      | Password        | password     |
      | Confirm Password| password     |
    And I press the "Sign up" button
    Then I will see an error message "Username is required"
    And I will remain on the signup page

  Scenario: Failed registration due to existing username/email
    Given I am on the signup page
    When I fill in the following:
      | Username        | existinguser |
      | Email           | existing@example.com |
      | Phone number    | 1234567890   |
      | Password        | password     |
      | Confirm Password| password     |
    And I press the "Sign up" button
    Then I will see an error message "Username already exists"
    And I will remain on the signup page

  Scenario: Failed registration due to password mismatch
    Given I am on the signup page
    When I fill in the following:
      | Username        | testuser     |
      | Email           | test@example.com |
      | Phone number    | 1234567890   |
      | Password        | password     |
      | Confirm Password| different    |
    And I press the "Sign up" button
    Then I will see an error message "Passwords do not match"
    And I will remain on the signup page

  Scenario: Failed registration due to invalid email format
    Given I am on the signup page
    When I fill in the following:
      | Username        | testuser     |
      | Email           | invalidemail |
      | Phone number    | 1234567890   |
      | Password        | password     |
      | Confirm Password| password     |
    And I press the "Sign up" button
    Then I will see an error message "Invalid email format"
    And I will remain on the signup page
