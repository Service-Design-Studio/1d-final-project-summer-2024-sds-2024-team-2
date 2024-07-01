Feature: Fill in User Particular Form
  As an undocumented user,
  I want to be able to enter my particulars
  So that I can view them on the “Confirmation” page

  Scenario: Empty fields on “Enter Particulars” page
    Given I am on the “Enter Particulars” page
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

  Scenario: Entering all Valid Particulars
    Given I enter the following particulars:
      | Full Name                 | Yirong
      | Phone Number              | 99999999
      | Secondary Phone Number    | 12345678
      | Country of Origin         | Singapore
      | Ethnicity                 | Chinese
      | Religion                  | Free-Thinker
      | Gender                    | Male
      | Date of Birth             | 03-05-2000
      | Date of Arrival in Malaysia | 10-06-2024
    When I press “Next”
    Then I will be redirected to the “Confirmation” page
    And I should see the filled-in details:
      | Full Name                 | Yirong
      | Phone Number              | 99999999
      | Secondary Phone Number    | 12345678
      | Country of Origin         | Singapore
      | Ethnicity                 | Chinese
      | Religion                  | Free-Thinker
      | Gender                    | Male
      | Date of Birth             | 03-05-2000
      | Date of Arrival in Malaysia | 10-06-2024

  Scenario: Missing Phone Number and Religion
    Given I enter the following particulars:
      | Full Name                 | Alice Tan
      | Secondary Phone Number    | 87654321
      | Country of Origin         | Malaysia
      | Ethnicity                 | Malay
      | Gender                    | Female
      | Date of Birth             | 12-04-1990
      | Date of Arrival in Malaysia | 20-01-2020
    And I do not enter a phone number
    And I do not select a religion
    When I press "Next"
    Then I will be prompted to fill in the "Phone Number" field
    And I should remain on the "Enter Particulars" page

    When I enter "99999999" into the "Phone Number" field
    And I press "Next"
    Then I will be prompted to fill in the "Religion" field
    And I should remain on the "Enter Particulars" page

    When I select "Islam" from the "Religion" dropdown
    And I press "Next"
    Then I will be redirected to the "Confirmation" page
    And I should see the filled-in details:
      | Full Name                 | Alice Tan
      | Phone Number              | 99999999
      | Secondary Phone Number    | 87654321
      | Country of Origin         | Malaysia
      | Ethnicity                 | Malay
      | Religion                  | Islam
      | Gender                    | Female
      | Date of Birth             | 12-04-1990
      | Date of Arrival in Malaysia | 20-01-2020

  Scenario: Missing Date of Birth and Country of Origin
    Given I enter the following particulars:
      | Full Name                 | Bob Lim
      | Phone Number              | 88888888
      | Secondary Phone Number    | 98765432
      | Ethnicity                 | Chinese
      | Religion                  | Buddhism
      | Gender                    | Male
      | Date of Arrival in Malaysia | 15-07-2018
    And I do not enter a date of birth
    And I do not select a country of origin
    When I press "Next"
    Then I will be prompted to fill in the "Date of Birth" field
    And I should remain on the "Enter Particulars" page

    When I enter "25-12-1985" into the "Date of Birth" field
    And I press "Next"
    Then I will be prompted to fill in the "Country of Origin" field
    And I should remain on the "Enter Particulars" page

    When I select "Singapore" from the "Country of Origin" dropdown
    And I press "Next"
    Then I will be redirected to the "Confirmation" page
    And I should see the filled-in details:
      | Full Name                 | Bob Lim
      | Phone Number              | 88888888
      | Secondary Phone Number    | 98765432
      | Country of Origin         | Singapore
      | Ethnicity                 | Chinese
      | Religion                  | Buddhism
      | Gender                    | Male
      | Date of Birth             | 25-12-1985
      | Date of Arrival in Malaysia | 15-07-2018
