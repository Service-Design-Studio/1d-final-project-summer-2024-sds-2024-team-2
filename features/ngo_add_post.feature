Feature: Interaction with common bulletin board
  As a non-governmental organization(NGO) personnel
  I want to access the common bulletin board and have a button to add posts
  So that I can view from other NGOs and post my own NGO's posts

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
