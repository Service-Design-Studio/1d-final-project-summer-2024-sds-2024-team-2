Feature: Confirm and View Particulars
  As an undocumented user,
  I want to confirm my particulars
  So that I can view my "Digital ID" on the main page

Scenario: All Fields Displayed
  Given I entered the following particulars:
    | Full Name                 | Alice Tan
    | Phone Number              | 99999999
    | Secondary Phone Number    | 87654321
    | Country of Origin         | Malaysia
    | Ethnicity                 | Malay
    | Religion                  | Islam
    | Gender                    | Female
    | Date of Birth             | 12-04-1990
    | Date of Arrival in Malaysia | 20-01-2020
  Then I should see the filled-in details:
    | Full Name                 | Alice Tan
    | Phone Number              | 99999999
    | Secondary Phone Number    | 87654321
    | Country of Origin         | Malaysia
    | Ethnicity                 | Malay
    | Religion                  | Islam
    | Gender                    | Female
    | Date of Birth             | 12-04-1990
    | Date of Arrival in Malaysia | 20-01-2020
  Then I press "Confirm" 
  And I should see the foli

Scenario: Secondary Phone Number Not Provided
  Given I entered the following particulars:
    | Full Name                 | Bob Lim
    | Phone Number              | 88888888
    | Secondary Phone Number    | 
    | Country of Origin         | Singapore
    | Ethnicity                 | Chinese
    | Religion                  | Buddhism
    | Gender                    | Male
    | Date of Birth             | 25-12-1985
    | Date of Arrival in Malaysia | 15-07-2018
  When I press "Confirm"
  Then I will be redirected to the "Digital ID" page
  And I should see the filled-in details:
    | Full Name                 | Bob Lim
    | Phone Number              | 88888888
    | Secondary Phone Number    | 
    | Country of Origin         | Singapore
    | Ethnicity                 | Chinese
    | Religion                  | Buddhism
    | Gender                    | Male
    | Date of Birth             | 25-12-1985
    | Date of Arrival in Malaysia | 15-07-2018

Scenario: Want to Go Back to Form to edit fields
  Given I enter the following particulars accordingly:
    | Full Name                 | Charlie Ng
    | Phone Number              | 77777777
    | Secondary Phone Number    | 55555555
    | Country of Origin         | Thailand
    | Ethnicity                 | Thai
    | Religion                  | Hinduism
    | Gender                    | Male
    | Date of Birth             | 20-11-1995
    | Date of Arrival in Malaysia | 05-05-2022
  And I press "Next"
  Then I will be redirected to the "Confirmation" page
  And I should see the filled-in details:
    | Full Name                 | Charlie Ng
    | Phone Number              | 77777777
    | Secondary Phone Number    | 55555555
    | Country of Origin         | Thailand
    | Ethnicity                 | Thai
    | Religion                  | Hinduism
    | Gender                    | Male
    | Date of Birth             | 20-11-1995
    | Date of Arrival in Malaysia | 05-05-2022
  When I press "Back"
  Then I should be redirected to the "Enter Particulars" page
  And I should see the previously filled-in details:
    | Full Name                 | Charlie Ng
    | Phone Number              | 77777777
    | Secondary Phone Number    | 55555555
    | Country of Origin         | Thailand
    | Ethnicity                 | Thai
    | Religion                  | Hinduism
    | Gender                    | Male
    | Date of Birth             | 20-11-1995
    | Date of Arrival in Malaysia | 05-05-2022
