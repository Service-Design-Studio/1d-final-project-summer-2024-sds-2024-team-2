Feature: Start Process of Filling User Particular Form
  As an undocumented user,
  I want to reach the “Enter Particulars” page,
  So that I can enter my particulars and start the registration process

  Scenario: Button to redirect to "Enter Particulars” page
    Given I am on the “Home” page 
    When I press "Fill in your particulars to get your Digital ID!"
    Then I should be redirected to the "Enter Particulars” page
    And I should see "Fill in your particulars"
