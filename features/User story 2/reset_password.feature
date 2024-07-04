Feature: reset password
    As an undocumented user
    I want to reach the “Enter Particulars” page
    So that I can enter my particulars and start the registration process

Scenario: Button to redirect to "Fill Particulars” page
    Given I am on the “Home” page 
    When I press "Fill in your particulars to get your Digital ID!"
    Then I should be redirected to the "Enter Particulars” page
    And I should see "Fill in your particulars"
