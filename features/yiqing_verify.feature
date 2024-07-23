Feature: View user particulars then verify
  As a non-governmental organization(NGO) personnel approached to help provide verification for an undocumented user's EnableID account on the 4th July 2024,
  I want to view information from his/her EnableID account to help determine the authenticity of his/her identity
  So that I can mark the personal particualrs of his/her EnableID account as verified.

Background:
  Given I am already on NGO "Gebirah" verify a user page
  

Scenario: Press Verify
  When I press the "Verify" button
  Then I should see "Verification successful for unique ID: 3665753."
  Then I should be redirected to the NGO "Gebirah" page
  