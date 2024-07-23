Feature: User Personal Page

Background:
    Given I am now on the user particulars home page as a verified user

Scenario: Navigating to the Personal page
    When I press on the "Personal" button
    Then I should be redirected to the "Personal" page
    And I should see the user particulars entered

Scenario: Editing user particulars
    When I change a field
    Then I should see a "Save Changes" button
    And I should see a "Discard Changes" button

Scenario: Saving changes
    Given I have changed a field on the "Personal" page
    When I press the "Save Changes" button
    Then a popup should appear with the message "Changes saved"
    And I should be able to navigate away from the page

Scenario: Attempting to navigate away without saving changes
    Given I have changed a field on the "Personal" page
    When I attempt to navigate away from the page without pressing "Save Changes"
    Then an alert should pop up
    And the alert should give the option to "Discard Changes" or "Save Changes"

