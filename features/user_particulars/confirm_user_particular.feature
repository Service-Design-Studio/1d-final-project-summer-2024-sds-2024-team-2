Feature: Confirm and View Particulars
  As an undocumented user,
  I want to confirm my particulars
  So that I can view my "EnableID" on the main page

Scenario: All Fields Displayed correctly
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
  | Date of Birth             | 31-12-2000 |
  | Date of Arrival in Malaysia | 01-07-2012 |
  And I press the "Submit" button
  Then I should see the following filled-in details
  | Field                     | Value        |
  | Full Name                 | Alice Tan    |
  | Phone Number              | +6599999999     |
  | Secondary Phone Number    | +6587654321     |
  | Country of Origin         | Malaysia     |
  | Ethnicity                 | Rohingya     |
  | Religion                  | Islam        |
  | Gender                    | Female       |
  | Date of Birth             | 31-12-2000   |
  | Date of Arrival | 01-07-2012 |
  Then I press the "Confirm" button
  Then I should be redirected to the "Home" page

Scenario: Secondary Phone Number Not Provided
  Given I am now on the fill in your particulars page as a new user
  Given I fill in the following fields
    | Full Name                 | Bob Lim |
    | Phone Number              | 88888888|
    | Country of Origin         | Singapore|
    | Ethnicity                 | Chinese|
    | Religion                  | Buddhism|
    | Gender                    | Male|
    | Date of Birth             | 25-12-1985|
    | Date of Arrival in Malaysia | 15-07-2018|
  And I press the "Submit" button
  Then I should see the following filled-in details
    | Full Name                 | Bob Lim|
    | Phone Number              | 88888888|
    | Secondary Phone Number    | +|
    | Country of Origin         | Singapore|
    | Ethnicity                 | Chinese|
    | Religion                  | Buddhism|
    | Gender                    | Male|
    | Date of Birth             | 25-12-1985|
    | Date of Arrival | 15-07-2018|
  Then I press the "Confirm" button
  Then I should be redirected to the "Home" page

Scenario: Want to Go Back to Form to edit fields
  Given I am now on the fill in your particulars page as a new user
  Given I fill in the following fields
    | Full Name                 | Charlie Ng |
    | Phone Number              | 77777777|
    | Secondary Phone Number    | 55555555|
    | Country of Origin         | Thailand|
    | Ethnicity                 | Thai|
    | Religion                  | Hinduism|
    | Gender                    | Male|
    | Date of Birth             | 20-11-1995|
    | Date of Arrival in Malaysia | 05-05-2022|
  And I press the "Submit" button
  Then I press the "Back" button
  Then I should be redirected to the "Fill in Particulars" page
  Then I should see the following filled-in details
    | Full Name                 | Charlie Ng |
    | Phone Number              | 77777777|
    | Secondary Phone Number    | 55555555|
    | Country of Origin         | Thailand|
    | Ethnicity                 | Thai|
    | Religion                  | Hinduism|
    | Gender                    | Male|
    | Date of Birth             | 20-11-1995|
    | Date of Arrival | 05-05-2022|