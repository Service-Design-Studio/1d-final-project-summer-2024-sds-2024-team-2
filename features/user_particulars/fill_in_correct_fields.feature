Feature: Fill in user particular form
  As an undocumented user,
  I want to get feedback when I enter my particulars incorrectly
  So that there are no mistakes in my inputs  

Background:
    Given I am now on the fill in your particulars page as a new user

Scenario: All invalid fields in fill in particulars
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

Scenario: Left blank fields in fill in particulars
    Given I fill in the following fields
    | Field                     | Value        |
    | Full Name                 | Alice Tan    |
    | Phone number              | 99999999     |
    | Secondary phone number    | 87654321     |
    | Country of Origin         |     |
    | Ethnicity                 | Rohingya     |
    | Religion                  | Islam        |
    | Gender                    | Female       |
    | Date of Birth             |    |
    | Date of Arrival in Malaysia | 01-07-2012 |
    And I press the "Submit" button
    Then I should stay on the "Fill in Particulars” page

Scenario: Left secondary phone number blank in fill in particulars
    Given I fill in the following fields
    | Field                     | Value        |
    | Full Name                 | Alice Tan    |
    | Phone number              | 99999999     |
    | Secondary phone number    |     |
    | Country of Origin         | Malaysia     |
    | Ethnicity                 | Rohingya     |
    | Religion                  | Islam        |
    | Gender                    | Female       |
    | Date of Birth             | 31-12-2000   |
    | Date of Arrival in Malaysia | 01-07-2012 |
    And I press the "Submit" button
    Then I should see his/her EnableID card