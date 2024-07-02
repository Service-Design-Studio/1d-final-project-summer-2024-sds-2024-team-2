Feature: Confirm and View Particulars
    As an undocumented user,
    I want to confirm my particulars
    So that I can view my "Digital ID" on the main page

Scenario: All Fields Displayed
    Given I am on login
    When I fill in the following:
        | email                 | Alice Tan |
    Then I should see "Alice Tan"