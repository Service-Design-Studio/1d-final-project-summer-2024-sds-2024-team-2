Feature: Fill in user particular form
  As an undocumented user,
  I want to get feedback when I enter my particulars incorrectly
  So that there are no mistakes in my inputs  

Scenario: All invalid fields in Register for EnableID
    Given I am on the "Login" page
    When I press the "Register for EnableID" button
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
    Given I am on the "Login" page
    When I press the "Register for EnableID" button
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

Scenario: All invalid fields in fill in particulars
    Given I am now on the fill in your particulars page as a new user
    Given I fill in the following fields
    | Field                     | Value        |
    | Full Name                 | Alice Tan123 |
    | Phone number              | 99999999abc  |
    | Secondary phone number    | 87654321abc  |
    | Country of Origin         | Malaysia     |
    | Ethnicity                 | Rohingya     |
    | Religion                  | Islam        |
    | Gender                    | Female       |
    | Date of Birth             | 31-12-2024   |
    | Date of Arrival in Malaysia | 01-07-2024 |
    And I press the "Submit" button
    Then I should see the following list of errors:
    | Full name can only contain valid letters and symbols. |
    | Phone number can only contain numbers and hyphens.    |
    | Secondary phone number can only contain numbers and hyphens. |
    | Date of birth cannot be in the future.                |
    | Date of arrival cannot be earlier than date of birth. |

Scenario: All valid fields in fill in particulars
    Given I am now on the fill in your particulars page as a new user
    Given I fill in the following fields
    | Field                     | Value        |
    | Full Name                 | Alice Tan    |
    | Phone number              | 99999999     |
    | Secondary phone number    | 87654321     |
    | Country of Origin         | Malaysia     |
    | Ethnicity                 | Rohingya     |
    | Religion                  | Islam        |
    | Gender                    | Female       |
    | Date of Birth             | 31-12-2000   |
    | Date of Arrival in Malaysia | 01-07-2012 |
    And I press the "Submit" button
    Then I should see his/her EnableID card