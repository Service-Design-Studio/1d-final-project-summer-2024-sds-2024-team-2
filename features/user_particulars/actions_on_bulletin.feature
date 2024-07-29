Feature: Interactions on the bulletin board
  As an EnableID user,
  I want to know more details about a particular Event Card on a bulletin board,
  And I want to send messages to NGOs directly with reference to a particular Event Card,
  And I want to be able to save Event Cards for a quick reference,
  So that I can easily navigate the use of the Event Cards posted by NGOs.

Background:
    Given I am now on the user particulars home page as a verified user
    And an event titled "Gebirah Aid Giveaway" with an ID of 1 exists

Scenario: Adding a saved post
    When I press on the unfilled bookmark icon on the "Gebirah Aid Giveaway", ID: "1" event card
    Then the bookmark icon for the "Gebirah Aid Giveaway", ID: "1" event card is filled
    When I press the "Saved Post" button
    Then I should be redirected to the "Saved Post" page
    And I should see the "Gebirah Aid Giveaway", ID: "1" event card

Scenario: Messaging a NGO
    When I press on the message icon on the "Gebirah Aid Giveaway", ID: "1" event card
    Then I should see a "What do you want to tell Gebirah?"
    And I should see a "Gebirah will be able see your message linked to this event card, together with your enableID"
    When I fill the message with "I would like to join this event but I will be late"
    And I press the "Send Message" button
    Then I should be redirected to the home page
    And I should see "Message successfully sent to Gebirah"

Scenario: Modal showing more details about the event card
    When I press on the event card "Gebirah Aid Giveaway", ID: "1"
    Then I should open up a modal with "Gebirah Aid Giveaway" as the header
    And I should see all the other details of the event card in the modal
    And I should see a "Send a Message" button
    And I should see a "Add to Saved" button

Scenario: Send message function on the opened modal
    Given I have opened up the modal on the event card "Gebirah Aid Giveaway", ID: "1"
    When I press the "Send a Message" button
    Then I should see a "What do you want to tell Gebirah?"
    And I should see a "Gebirah will be able see your message linked to this event card, together with your enableID"
    When I fill the message with "I would like to join this event but I will be late"
    And I press the "Send Message" button
    Then I should be redirected to the home page
    And I should see "Message successfully sent to Gebirah"

Scenario: Adding a saved post function on the opened modal
    Given I have opened up the modal on the event card "Gebirah Aid Giveaway", ID: "1"
    When I press the "Add to Saved" button
    Then I should see a "Saved" button
    And the bookmark icon on the "Saved" button should be filled

    Given I close the modal
    Then the bookmark icon for the "Gebirah Aid Giveaway", ID: "1" event card is filled
    When I press the "Saved Post" button
    Then I should be redirected to the "Saved Post" page
    And I should see the "Gebirah Aid Giveaway", ID: "1" event card


