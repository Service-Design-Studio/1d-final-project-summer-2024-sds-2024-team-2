Feature: Documents Page

Background:
    Given I am now on the user particulars home page as a verified user

Scenario: Navigating to the Documents page
    When I press on the "Documents" button
    Then I should be redirected to the "Documents" page
    And I should see all the documents I have previously uploaded
    And I should see an "Upload Documents" button

Scenario: Uploading a document
    Given I am on the "Documents" page
    When I press on the "Upload Documents" button
    Then I should be redirected to the "Upload Document" page

Scenario: Removing a document
    Given I am on the "Documents" page
    And I see a "Remove Document" button next to a document
    When I press on the "Remove Document" button
    Then a confirmation popup should appear asking "Are you sure you want to remove this document?"
    And I should see options to confirm or cancel the removal

Scenario: Viewing a document
    Given I am on the "Documents" page
    When I press on the specific document name
    Then I should be able to view the document