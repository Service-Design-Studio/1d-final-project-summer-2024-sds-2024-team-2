Feature: User Home Page

Background:
    Given I am now on the user particulars home page as a verified user

Scenario: Viewing the QR code (back of the card)
    Given the Digital ID is showing my information
    When I press on the "QR code" icon button
    Then the digitalID card will flip
    And I should see a unique QR code

Scenario: Viewing DigitalID (front of the card)
    Given the Digital ID is showing the unique QR code
    When I press on the "card" icon button
    Then the digitalID card will flip
    And I should see a unique my information

Scenario: Generating a 2FA passcode
    When I click on the "Generate 2FA passcode" button
    Then I should see a 2FA passcode generated

Scenario: Navigating to the Documents page
    When I press on the "Documents" button
    Then I should be redirected to the "Documents" page

Scenario: Navigating to the Activity History page
    When I press on the "Activity History" button
    Then I should be redirected to the "Activity History" page
    And I should see a list of my recent activities
    And each activity should display the date, time, and description
    And the activities should be displayed with the latest activity at the top

Scenario: Navigating to the Personal page
    When I press on the "Personal" button
    Then I should be redirected to the "Personal" page
    And I should see the user particulars I had previosly entered

Scenario: Navigating to the Family page
    When I press on the "Family" button
    Then I should be redirected to the "Family" page
    And I should see a list of added family members
    And each family member should display their name, relationship, and contact information
    And I should see a form to add more family members
    And the form should include fields for name, relationship, and contact information
    And I should see an "Add Family Member" button
    When I press on the "Add Family Member" button in the form
    Then the new family member should be added to the list

Scenario: Navigating to the Saved Post page
    When I press on the "Saved Post" button
    Then I should be redirected to the "Saved Post" page
    And I should see a list of my saved posts
    And each post should display its title, author, and date saved
    And I should see options to unsave the saved post
    And I should see a search bar to filter saved posts in real time

Scenario: Navigating to the Search NGOs page
    When I press on the "Search NGOs" button
    Then I should be redirected to the "Search NGOs" page
    And I should see a list of NGOs


Feature: Bulletin Board on User Home Page

Scenario: Post displayed by latest posted
    When I view the list of posts
    Then the posts should be displayed in descending order of their posted time
    And the most recently posted post should appear at the top of the list
    And each post should display the title, author, and posted time, details, and image

Scenario: Saved Post
    When I press the "Save" icon button on a post
    Then the post should be saved to my saved posts list at
    And I should see a confirmation message "Post saved successfully"
    When I navigate to the "Saved Posts" page
    Then I should see the saved post in the list
    And the saved post should display the title and a brief description

Scenario: Navigating to more information on the post by clicking
    When I press on a post Title "Humanitarian Aid", by "Gebirah", Posted "23 mins ago",
    Then I should be redirected to that "Post" page
    And I should see the post details

Scenario: Search for Post
    When I enter "Gebirah" into the search bar
    Then the posts should start filtering in real-time
    And I should see a list of posts related to "Gebirah"

 