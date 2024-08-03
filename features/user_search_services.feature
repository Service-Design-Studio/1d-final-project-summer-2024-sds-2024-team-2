Feature: Search Services Page

Background:
    Given I am now on the user particulars home page as a verified user

Scenario: Navigating to the Search Services page
    When I press on the "Search Services" button
    Then I should be redirected to the "Search Services" page
    And I should see a list of NGOs with their contact informations
    And I should see a "Send a message "button in each ngo
    And I should see a search bar to filter NGOs in real time

Scenario: Searching for Services
    Given I am on the "Search Services" page
    When I enter "Education" into the services search bar
    Then I should only see a list of NGO cards related to "Education"

Scenario: Messaging a NGO
    Given I am on the "Search Services" page
    When I press on the "Send a message" button on the "Gebirah" card
    Then I should see "Send a message to Gebirah:"
    And I should see "Gebirah will be able to see your message, together with your EnableID information"
    When I fill the message with "Hi, I need help regarding Education, can you contact me at your as soon as possible, preferably by email"
    And I press the "Send message" button
    Then I should be redirected to the "Search Services" page
    And I should see "Message successfully sent to Gebirah!"

Scenario: Close messaging a NGO
    Given I am on the "Search Services" page
    When I press on the "Send a message" button on the "Gebirah" card
    Then I should see "Send a message to Gebirah:"
    And I should see "Gebirah will be able to see your message, together with your EnableID information"
    And I press the "Close" button
    Then I should be redirected to the "Search Services" page
