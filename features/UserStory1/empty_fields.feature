Feature: Empty fields on "Enter Particulars" page
  As an undocumented user,
  I want to see empty fields on the "Enter Particulars" page,
  So that I can enter my particulars

  Scenario: Empty fields on "Enter Particulars" page
    Given I am on the "enter particulars" page
    Then I should see the following fields:
      | Full Name                 |
      | Phone Number              |
      | Secondary Phone Number    | (optional)
      | Country of Origin         | (dropdown)
      | Ethnicity                 | (dropdown)
      | Religion                  | (dropdown)
      | Gender                    | (dropdown)
      | Date of Birth             | (date)
      | Date of Arrival in Malaysia | (date)
    And the fields should be empty
