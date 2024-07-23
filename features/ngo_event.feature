Feature: Create and manage event
  As a non-governmental organization(NGO) personnel
  I want to create an event and manage attendance
  So that I can track participation and distribution of items

Scenario: Creating an event
  Given I am on the NGO "Gebirah" page
  When I press the "Create Event" button
  Then I should be redirected to the create event page
  And I should see a form to enter event details
  When I fill in the form and press the "Create event" button
  Then my event should be created
  And I should see a confirmation message "Event created successfully"

Scenario: Refugee has already collected food at the event
  Given I have created an event and already on the event page
  When I key in the Unique ID: '3665753' or scan the refugee's QR code
  Then I should see a message "Food has already been collected by Unique ID: 3665753"

Scenario: Refugee is collecting food at the event for the first time
  Given I have created an event and already on the event page
  When I key in the Unique ID: '3665753' or scan the refugee's QR code
  Then I should see a message "Food collected"