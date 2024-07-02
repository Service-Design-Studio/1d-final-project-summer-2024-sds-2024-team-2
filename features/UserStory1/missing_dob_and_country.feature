Feature: Missing Date of Birth and Country of Origin
  As an undocumented user,
  I want to be prompted to fill in required fields,
  So that I can complete my particulars

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
    And I should remain on the "enter particulars" page

    When I enter "25-12-1985" into the "Date of Birth" field
    And I press "Next"
    Then I will be prompted to fill in the "Country of Origin" field
    And I should remain on the "enter particulars" page

    When I select "Singapore" from the "Country of Origin" dropdown
    And I press "Next"
    Then I will be redirected to the "confirmation" page
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
