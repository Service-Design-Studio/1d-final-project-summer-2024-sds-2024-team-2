Feature: Messaging a NGO

Background:
    Given I am already on the NGO "Gebirah" page 
    And user1 send a message "Hi, I need help regarding Education, can you contact me at your as soon as possible, preferably by email" to Gebirah

Scenario: Navigating to inbox page
    When I press on the "Inbox" button
    Then I should be redirected to the "Inbox" page
    And I should see a list of past messages recieved

Scenario: Viewing message details
    Given I am on the "Inbox" page
    When I click on the first message
    Then I should see the details of the first message in the details panel
