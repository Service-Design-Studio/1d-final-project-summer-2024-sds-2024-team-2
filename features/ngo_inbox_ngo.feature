Feature: Messaging a NGO

Background:
    Given I am already on the NGO "Gebirah" page
    
Scenario: Navigating to inbox page
    When I press on the "Inbox" button
    Then I should be redirected to the NGO "Gebirah" "inbox" page
    And I should see a list of past messages received


Scenario: Viewing message details
    Given I am on the NGO "Gebirah" "inbox" page
    When I click on the first message
    Then I should see the details of the first message in the details panel

