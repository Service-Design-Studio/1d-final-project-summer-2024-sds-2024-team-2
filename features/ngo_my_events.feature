Feature: Add and manage events in the common bulletin board
  As a non-governmental organization(NGO) personnel
  I want to add events to the common bulletin board and have a button view my events
  So that I can post and view my events

Background:
  Given I am already on the NGO "Gebirah" page

Scenario: Add event to bulletin board
  When I press the "Add Bulletin Post" button
  Given I fill in the following fields
  | Field                     | Value             |
  | Title                     | Event 1           |
  | Description               | Food Distribution |
  | Date                      | 31-1-2024         |
  | Location                  | Malaysia          |
  And I press the "Add Post" button
  Then I should see "Post added successfully."
  And I should see the added post by NGO on the bulletin board

Scenario: View my events
  When I press the "My Events" button
  Then I should be redirected to the "My Events" page
  And I should see a list of events posted by my NGO

Scenario: Viewing added event on bulletin board on user home page
  Given I am on the user home page
  Then I should see the added post by NGO on the bulletin board



