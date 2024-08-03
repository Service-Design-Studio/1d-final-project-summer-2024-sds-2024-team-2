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
  Then I should see event card with the following fields
  | Field                     | Value             |
  | Title                     | Event 1           |
  | Description               | Food Distribution |
  | Date                      | 31-1-2024         |
  | Location                  | Malaysia          |

Scenario: Viewing added post on bulletin board on user home page
  Given I am now logged in to the user particulars home page
  Then I should see event card with the following fields
  | Field                     | Value             |
  | Title                     | Event 1           |
  | Description               | Food Distribution |
  | Date                      | 31-1-2024         |
  | Location                  | Malaysia          |

Scenario: Missing fields when adding posts
  When I press the "Add Bulletin Post" button
  Given I fill in the following fields
  | Field                     | Value             |
  | Title                     |                   |
  | Description               | Food Distribution |
  | Date                      | 31-1-2024         |
  | Location                  | Malaysia          |
  Then I should see a validation message "Please fill out this field."

Scenario: Add photo to event post
  When I press the "Add Bulletin Post" button
  Given I fill in the following fields
  | Field                     | Value             |
  | Title                     | Event 1           |
  | Description               | Food Distribution |
  | Date                      | 31-1-2024         |
  | Location                  | Malaysia          |
  And I press the "Upload a photo here" button
  When I press the "Add Post" button
  Then I should see event card with the uploaded photo