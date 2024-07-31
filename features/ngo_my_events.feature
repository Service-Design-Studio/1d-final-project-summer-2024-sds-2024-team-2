Feature: Add and manage events in the common bulletin board
  As a non-governmental organization(NGO) personnel
  I want to add events to the common bulletin board and have a button view my events
  So that I can post and view my events

Background:
  Given I am already on the NGO "Gebirah" page

Scenario: Adding a message to the common bulletin board
  When I press the "Add Bulletin Post" button
  Given I fill in the following fields
  | Field                     | Value             |
  | Title                     | Event 1           |
  | Description               | Food Distribution |
  | Date                      | 31-1-2024         |
  | Location                  | Malaysia          |
  And I press the "Add Post" button
  Then I should see "Post added successfully."
  Then I should see event card with the following fields
  | Field                     | Value             |
  | Title                     | Event 1           |
  | Description               | Food Distribution |
  | Date                      | 31-1-2024         |
  | Location                  | Malaysia          |

Scenario: View my events
  When I press the "My Events" button
  Then I should see event cards by my NGO only

Scenario: Empty bulletin board
  Given my NGO has no posts
  When I press the "My Events" button
  Then I should see "No posts yet"

Scenario: Change to normal view of bulletin board after pressing My Events button
  When I press the "My Events" button
  Then I should see event cards by my NGO only
  When I press the "View All Events" button
  Then I should see event cards by all NGOs


Scenario: Viewing added post on bulletin board on user home page
  Given I am now on the user particulars home page as a new user
  Then I should see event card with the following fields
  | Field                     | Value             |
  | Title                     | Event 1           |
  | Description               | Food Distribution |
  | Date                      | 31-1-2024         |
  | Location                  | Malaysia          |



