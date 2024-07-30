Feature: Adding and removing saved post
  As an EnableID user,
  I want to bookmark events on the bulletin board that I am interested in
  So that I can refer and stay updated about these events conveniently

Background:
    Given I am now on the user particulars home page as a verified user
    And an event titled "Gebirah Aid Giveaway" with an ID of 1 exists

Scenario: Empty Saved Post page
    When I press the "Saved Post" button
    Then I should be redirected to the "Saved Post" page
    And I should see "There are no saved posts!"

Scenario: Adding a saved post and removing it in Saved Post page
    When I press on the unfilled bookmark icon on the "Gebirah Aid Giveaway", ID: "1" event card
    Then the bookmark icon for the "Gebirah Aid Giveaway", ID: "1" event card is filled
    When I press the "Saved Post" button
    Then I should be redirected to the "Saved Post" page
    And the "Gebirah Aid Giveaway", ID: "1" event card should be present
    When I press on the filled bookmark icon on the "Gebirah Aid Giveaway", ID: "1" event card
    Then I should not see the "Gebirah Aid Giveaway", ID: "1" event card
    When I press the "Back" button
    Then I should see the "Gebirah Aid Giveaway", ID: "1" event card
    And the "Gebirah Aid Giveaway", ID: "1" event card bookmark icon should become unfilled

Scenario: Adding a saved post, then immediately retracting it, then going into the Saved Post page
    When I press on the unfilled bookmark icon on the "Gebirah Aid Giveaway", ID: "1" event card
    Then the bookmark icon for the "Gebirah Aid Giveaway", ID: "1" event card is filled
    When I press on the filled bookmark icon on the "Gebirah Aid Giveaway", ID: "1" event card
    Then the "Gebirah Aid Giveaway", ID: "1" event card bookmark icon should become unfilled
    When I press the "Saved Post" button
    Then I should be redirected to the "Saved Post" page
    And I should see "There are no saved posts!"

