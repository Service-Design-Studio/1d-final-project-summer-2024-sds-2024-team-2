Feature: Activity History for EnableID user
  As an EnableID user,
  I want to have a record of all the activities I have done with my EnableID account
  So that I am able to reference my account activities with NGOs whenever necessary

Background:
    Given I am now on the fill in your particulars page as a new user

Scenario: Account creation, user particulars, and verification
    When I press the "Activity History" button
    Then I should be redirected to the "Activity History" page
    And I should see "EnableID account created!"
    When I press the "Back" button
    Then I should be redirected to the "Home" page

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
    Then I press the "Confirm" button
    Then I should be redirected to the "Home" page