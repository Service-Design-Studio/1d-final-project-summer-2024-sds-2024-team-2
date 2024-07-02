Feature: Entering all Valid Particulars
  As an undocumented user,
  I want to enter all valid particulars,
  So that I can view them on the “Confirmation” page

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
    Then I will be redirected to the “confirmation” page
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
