Feature: Confirm and View Particulars
  As an undocumented user,
  I want to confirm my particulars
  So that I can view my "Digital ID" on the main page

Background:
  Given I am a logged-in user
  And I press the "Fill in your particulars to get your Digital ID!" button

Scenario: All Fields Displayed
  Given I entered the following particulars:
    | Field                     | Value        |
    | Full Name                 | Alice Tan    |
    | Phone Number              | 99999999     |
    | Secondary Phone Number    | 87654321     |
    | Country of Origin         | Malaysia     |
    | Ethnicity                 | Gurka        |
    | Religion                  | Islam        |
    | Gender                    | Female       |
    | Date of Birth             | 12-04-1990   |
    | Date of Arrival in Malaysia | 20-01-2020 |
    
  Then I should see the following fields:
    | Field                     | Value        |
    | Full Name                 | Alice Tan    |
    | Phone Number              | 99999999     |
    | Secondary Phone Number    | 87654321     |
    | Country of Origin         | Malaysia     |
    | Ethnicity                 | Gurka        |
    | Religion                  | Islam        |
    | Gender                    | Female       |
    | Date of Birth             | 12-04-1990   |
    | Date of Arrival in Malaysia | 20-01-2020 |