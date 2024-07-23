Feature: Checklist before Verify button
    As a non-givernmental organization (NGO) personnel approached to help provide verification for an undocumented user's EnableID account
    I want to view information from his/her EnableID account and have a verification checklist to help determine the authenticity of his/her identity 
    So that I can mark the personal particulars of his/her EnableID account as verified. 

Background: 
    Given a user particular exists with unique ID "3665753" and 2FA code "310263"

Scenario: Going to my own "NGO" page
    Given I am on the "Login" page
    When I press the "I am a NGO" button
    Then I should see a set of different NGO buttons 
    When I press the NGO "Gebirah" card
    Then I should be redirected to the NGO "Gebirah" page

Scenario: Retrieving undocumented user's EnableID personal particulars, then complete the verification checklist below the EnableID
    Given I am already on my NGO "Gebirah" page 
    When I key in the unique ID: '3665753' and 6 digit code 2FA: '310263', then I press the check button
    Then I should be redirected to the User Verification page under "Gebirah" 
    And I should see his/her EnableID card 
    And I should see "3665753" 
    And I should see a verification checklist right below the EnableID card
    And I should see "Verify" button 

    When I complete the verification checklist
    Then I should be able to press the "Verify" button 

    When I press the "Verify" button 
    Then I should see "Verification successful for unique ID: 3665753."
    Then I should be redirected to the NGO "Gebirah" page

Scenario: Incompletion of verification checklist 
    Given I am already on the User verification page under "Gebirah" 
    When I did not complete the verification checklist 
    And I press the "Verify" button 
    Then I should see a notice "Please complete the verification checklist"


Feature: Keep-in-view button
    As a non-governmental organization(NGO) personnel approached to help provide verification for an undocumented user's EnableID account
    I want to have a keep-in-view button after viewing information from his/her EnableID account to help determine the authenticity of his/her identity
    so that I can review and confirm their verification on a later date   

Background:
  Given a user particular exists with unique ID "3665753" and 2FA code "310263"

Scenario: Going to my own "NGO" page
    Given I am on the "Login" page
    When I press the "I am a NGO" button
    Then I should see a set of different NGO buttons 
    When I press the NGO "Gebirah" card
    Then I should be redirected to the NGO "Gebirah" page

  Scenario: Retrieving undocumented user's EnableID personal particulars, then complete the verification checklist below the EnableID
    Given I am already on my NGO "Gebirah" page 
    When I key in the unique ID: '3665753' and 6 digit code 2FA: '310263', then I press the check button
    Then I should be redirected to the User Verification page under "Gebirah" 
    And I should see his/her EnableID card 
    And I should see "3665753" 
    And I should see a verification checklist right below the EnableID card
    And I should see "Verify" button 
    And I should see "keep-in-view" button 

    When I am not able to complete the verification checklist 
    Then I should press the "keep-in-view" button 
    When I press the "keep-in-view" button 
    Then I should be redirected to the NGO "Gebriah" page keep-in-view folder 