Feature: Registering for an account
  As an undocumented user,
  I want to get feedback when I enter my particulars incorrectly
  So that I can register an account

Background:
    Given I am on the "Login" page
    When I press the "Register for EnableID" button
    Then I should be redirected to the "Registration" page

Scenario: All valid fields in Register for EnableID
    Given I fill in the following fields
    | Field                   | Value        |
    | Username                | User12345 |
    | Password (Please ensure you can remember this)  | 123123 |
    | Password confirmation   | 123123          |
    | Email                   | abcdefg@mail.com  |
    | Contact number          | 12341234    |
    And I press the "Register" button
    Then I should be redirected to the "Home" page

Scenario: All invalid fields in Register for EnableID
    Given I fill in the following fields
    | Field                   | Value        |
    | Username                | Alice Tan123 |
    | Password (Please ensure you can remember this)  | 123 |
    | Password confirmation   | abc          |
    | Email                   | abcdefg.com  |
    | Contact number          | number999    |
    And I press the "Register" button
    Then I should see the following list of errors:
    | Email is invalid |
    | Password confirmation doesn't match Password    |
    | Password is too short (minimum is 6 characters) |
    | Phone number is invalid                         |

Scenario: All already taken fields in Register for EnableID
    Given I fill in the following fields
    | Field                   | Value           |
    | Username                | user1           |
    | Password (Please ensure you can remember this)  | 123 |
    | Password confirmation   | abc             |
    | Email                   | user1@mail.com  |
    | Contact number          | 90000001        |
    And I press the "Register" button
    Then I should see the following list of errors:
    | Username has already been taken       |
    | Email has already been taken          |
    | Phone number has already been taken   |

Scenario: Left Username blank fields in Register for EnableID
    Given I fill in the following fields
    | Field                   | Value           |
    | Username                |           |
    | Password (Please ensure you can remember this)  | abc123 |
    | Password confirmation   | abc123             |
    | Email                   | user1@mail.com     |
    | Contact number          | 90000001        |
    And I press the "Register" button
    Then I should stay on the "Registration" page