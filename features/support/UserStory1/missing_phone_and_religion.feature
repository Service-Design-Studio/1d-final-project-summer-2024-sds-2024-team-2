Feature: Missing Phone Number and Religion
  As an undocumented user,
  I want to be prompted to fill in required fields,
  So that I can complete my particulars

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
    And I should remain on the "enter particulars" page

    When I enter "99999999" into the "Phone Number" field
    And I press "Next"
    Then I will be prompted to fill in the "Religion" field
    And I should remain on the "enter particulars" page

    When I select "Islam" from the "Religion" dropdown
    And I press "Next"
    Then I will be redirected to the "confirmation" page
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
