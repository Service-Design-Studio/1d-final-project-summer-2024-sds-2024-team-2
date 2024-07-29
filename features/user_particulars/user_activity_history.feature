Feature: Activity History for EnableID user
  As an EnableID user,
  I want to have a record of all the activities I have done with my EnableID account
  So that I am able to reference my account activities with NGOs whenever necessary

Background:
    Given I am now on the user particulars home page as a new user

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

    When I press the "Activity History" button
    Then I should see "User Particulars Updated! Pending verification."
    And I should see "EnableID account created!"   
    When I press the "Back" button
    Then I should be redirected to the "Home" page

    Given I was just verified by "Gebirah"
    When I press the "Activity History" button
    Then I should see "User Particulars verified by Gebirah!"
    And I should see "User Particulars Updated! Pending verification."
    And I should see "EnableID account created!"   
    When I press the "Back" button
    Then I should be redirected to the "Home" page

Scenario: Storing archive of sent messages
    Given I have opened up the modal on the event card "Gebirah Aid Giveaway", ID: "1"
    When I press the "Send a Message" button
    And I fill the message with "I would like to join this event but I will be late"
    And I press the "Send Message" button
    Then I should be redirected to the home page
    When I press the "Activity History" button
    Then I should see "Gebirah Aid Giveaway: Message sent to Gebirah!"

Scenario: Storing archive of sent messages from saved NGOs
    When I press the "Search NGOs" button
    Then I should be redirected to the "Search NGOs" page
    When I press the "Send a Message" button for Gebirah
    And I fill the message with "Hello!"
    And I press the "Send" button
    Then I should see "Message sent to Gebirah!"
    When I press the "Back" button
    Then I should be redirected to the home page
    When I press the "Activity History" button
    Then I should see "Message sent to Gebirah!"
