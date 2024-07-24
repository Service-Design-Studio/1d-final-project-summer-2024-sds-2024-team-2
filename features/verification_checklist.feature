Feature: Checklist before Verify button
    As a non-givernmental organization (NGO) personnel approached to help provide verification for an undocumented user's EnableID account
    I want to view information from his/her EnableID account and have a verification checklist to help determine the authenticity of his/her identity 
    So that I can mark the personal particulars of his/her EnableID account as verified. 

Background: 
    Given I am already on NGO "Gebirah" verify a user page

Scenario: Complete the verification checklist 
    When I click all the boxes in the verification checklist
    And I press the "Verify" button 
    Then I should be redirected to the NGO "Gebirah" page
    Then I should see a success message stating "Verification successful for unique ID: 1055290."
    
Scenario: Incompletion of verification checklist 
    When I did not click all the boxes in the verification checklist 
    Then I am not able to press the "Verify" button 
 


