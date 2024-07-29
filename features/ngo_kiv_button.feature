Feature: Keep-In-View button

Background: 
    Given I am already on NGO "Gebirah" verify a user page 

Scenario: Press Keep-In-View button when not able to complete verification checklist 
    When I did not click all the boxes in the verification checklist 
    Then I am not able to press the "Verify" button 
    And I press the "Keep-In-View" button 
    Then I should be redirected to the NGO "Gebirah" page 
    Then I should see a success message stating " Unique ID: 1055290 is archived. " 

Scenario: List of users who has not been verififed is found in archive file
    Given I am already on the NGO "Gebirah" page 
    When I press on the "Archive" button
    Then I should be redirected to the "Archive" page 
    Then I should see the Digital ID card of Unique ID: 1055290
