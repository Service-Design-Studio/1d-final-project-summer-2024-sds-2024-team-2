Feature: Start process of filling user particular form
    As an undocumented user
    I want to reach the “Enter Particulars” page
    So that I can enter my particulars and start the registration process

Background:
    Given I am now on the user particulars home page as a new user

Scenario: Button to redirect to "Fill Particulars” page
    When I press the "Fill in your particulars to get your Digital ID!" button
    Then I should see "Fill in your particulars"
