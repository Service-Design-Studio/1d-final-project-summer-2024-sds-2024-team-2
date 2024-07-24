Feature: Search NGOs Page

Background:
    Given I am now on the user particulars home page as a verified user

Scenario: Navigating to the Search NGOs page
    When I press on the "Search NGOs" button
    Then I should be redirected to the "Search NGOs" page
    And I should see a list of NGOs
    And I should see a search bar to filter NGOs in real time

Scenario: Viewing NGO details
    Given I am on the "Search NGOs" page
    Then each NGO should include its name, contact number, email, website, and locations

Scenario: Starting a chat with an NGO
    Given I am on the "Search NGOs" page
    When I press on the "Chat" button for a specific NGO
    Then a chat window should open to start a conversation with the selected NGO

Scenario: Viewing chat history with an NGO
    Given I am on the "Search NGOs" page
    And I have previously started a chat with a specific NGO
    When I press on the "Chat" button for the specific NGO
    Then a chat window should open
    And I should see a section labeled "Previous Chats"
    And the "Previous Chats" section should include all previous messages exchanged with the NGO

Scenario: Viewing previous chats area
    Given I am on the "Search NGOs" page
    Then I should see an area labeled "Previous Chats"
    And the "Previous Chats" area should show the latest chats at the top
    And each chat should display a glimpse of the last message exchanged between the two parties
    When I click on a chat in the "Previous Chats" area
    Then the chat window should open with the full chat history with the selected NGO

Scenario: Sorting NGOs
    Given I am on the "Search NGOs" page
    And I should see a "Sort By" dropdown to sort NGOs by name, location, or relevance