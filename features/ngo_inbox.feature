Feature: Messaging a NGO

Background:
    Given I am now logged in to the user particulars home page

Scenario: Navigating to search service page
    When I press on the "Search for Services" button
    Then I should be directed to the "Contact NGO" page

Scenario: Send a message to NGO
    Given I am already on the Contact NGO page
    When I click on the send message button
    And I fill in the message form with "Hi, I need help regarding Education, can you contact me at your as soon as possible, preferably by email"
    And I submit the message form
    Then I should see a flash message "Message successfully sent to Gebirah!"
    
