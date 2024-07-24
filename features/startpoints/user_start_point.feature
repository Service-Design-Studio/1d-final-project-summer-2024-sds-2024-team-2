Feature: Start process of filling user particular form
    As an undocumented user
    I want to reach the “Enter Particulars” page
    So that I can enter my particulars and start the registration process

Scenario: Redirect to "Fill Particulars” page
    Given I am now on the user particulars home page as a new user
    When I press the "Fill in your particulars to get your Digital ID!" button
    Then I should see "Fill in your particulars"

Scenario: Redirect to "Edit your particulars!" page
    Given I am now on the user particulars home page as a verified user
    When I press the "Edit" button
    Then I should see "Caution!"
    When I press the "Proceed" button
    Then I should see "Edit your particulars"

Scenario: Redirect to "Upload Documents!" page
    Given I am now on the fill in your particulars page as a new user
    When I fill in the following fields
    | Field                     | Value        |
    | Full Name                 | Alice Tan    |
    | Phone number              | 99999999     |
    | Secondary phone number    | 87654321     |
    | Country of Origin         | Malaysia     |
    | Ethnicity                 | Rohingya     |
    | Religion                  | Islam        |
    | Gender                    | Female       |
    | Date of Birth             | 12-04-2000   |
    | Date of Arrival in Malaysia | 20-01-2020 |
    And I press the "Submit" button



