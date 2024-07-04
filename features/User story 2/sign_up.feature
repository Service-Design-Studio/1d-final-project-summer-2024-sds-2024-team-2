Feature: User Sign Up
Background:
    Given I am on the "Login" Page,
    When I press "Register for Digital ID" button
    Than I be redirected to the "Registration" page.

Scenario: Empty Fields on "Registration" page
    Given I am on the "Registration" page,
    Then I should see the following fields:
    | Username                   |
    | Password                   | (minimum 6 characters)
    | Password confirmation      |
    | Email                      |
    | Contact Number             |
    And the fields should be empty.

Scenario: Successful Sign Up
    Given I am on the "Registration" page,
    When I fill in the following particulars accordingly:
    | Username                   | user123
    | Password                   | password1
    | Password confirmation      | password1
    | Email                      | user123@example.com
    | Contact Number             | 1234567890
    And I press "Register",
    Than I be redirected to the "Registration" page.
    Then I should see a welcome message,

Scenario: Sign Up with Missing Required Fields
    Given I am on the "Registration" page,
    When I leave one or more required fields blank,
    | Username                   | user128
    | Password                   | 
    | Password confirmation      | 
    | Email                      | user128@example.com
    | Contact Number             | 4455667788
    And I press "Register",
    Then I should see an error message indicating that all required fields must be filled.
    And I should remain on the "Registration" page.

Scenario: Sign Up with an Already Taken Username
    Given I am on the "Registration" page,
    When I fill in the following particulars accordingly:
    | Username                   | username
    | Password                   | password2
    | Password confirmation      | password2
    | Email                      | user123@example.com
    | Contact Number             | 0987654321
    And I press "Register",
    Then I should see an error message indicating that the username is already in use.
    And I should remain on the "Registration" page.

Scenario: Sign Up with Mismatched Passwords
    Given I am on the "Registration" page,
    When I fill in the following particulars accordingly:
    | Username                   | user127
    | Password                   | password4
    | Password confirmation      | differentpassword
    | Email                      | user127@example.com
    | Contact Number             | 3344556677
    And I press "Register",
    Then I should see an error message indicating that the passwords do not match.
    And I should remain on the "Registration" page.

Scenario: Sign Up with Passwords less than 6 characters
    Given I am on the "Registration" page,
    When I fill in the following particulars accordingly:
    | Username                   | user127
    | Password                   | pass
    | Password confirmation      | pass
    | Email                      | user127@example.com
    | Contact Number             | 3344556677
    And I press "Register",
    Then I should see an error message indicating that the passwords needed to have a minimum of 6 characters.
    And I should remain on the "Registration" page.

Scenario: Sign Up with an Already Taken Email
    Given I am on the "Registration" page,
    When I fill in the following particulars accordingly:
    | Username                   | user124
    | Password                   | password2
    | Password confirmation      | password2
    | Email                      | user123@example.com
    | Contact Number             | 0987654321
    And I press "Register",
    Then I should see an error message indicating that the email is already in use.
    And I should remain on the "Registration" page.

Scenario: Sign Up with an Invalid Email
    Given I am on the "Registration" page,
    When I fill in the following particulars accordingly:
    | Username                   | user125
    | Password                   | password3
    | Password confirmation      | password3
    | Email                      | invalidemail
    | Contact Number             | 1122334455
    And I press "Register",
    Then I should see an error message indicating that the email address is invalid.
    And I should remain on the "Registration" page.

Scenario: Sign Up with Already Taken Phone Number
    Given I am on the "Registration" page,
    When I fill in the following particulars accordingly:
    | Username                   | user129
    | Password                   | password5
    | Password confirmation      | password5
    | Email                      | user129@example.com
    | Contact Number             | 12345678
    And I press "Register",
    Then I should see an error message indicating that the phone number is already in use.
    And I should remain on the "Registration" page.

Scenario: Sign Up with Invalid Phone Number
    Given I am on the "Registration" page,
    When I fill in the following particulars accordingly:
    | Username                   | user129
    | Password                   | password5
    | Password confirmation      | password5
    | Email                      | user129@example.com
    | Contact Number             | invalidnumber
    And I press "Register",
    Then I should see an error message indicating that the phone number is invalid.
    And I should remain on the "Registration" page.

Scenario: Pressing Cancel
    Given I am on the "Registration" page,
    And I press "Cancel",
    And I should be redirected to the "Login" page.