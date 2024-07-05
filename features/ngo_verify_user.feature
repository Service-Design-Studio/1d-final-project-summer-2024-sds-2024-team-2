Feature: Verify user particulars and account
  As a non-governmental organization(NGO) personnel approached to help provide verification for an undocumented user's EnableID account on the 4th July 2024,
  I want to view information from his/her EnableID account to help determine the authenticity of his/her identity
  So that I can mark the personal particualrs of his/her EnableID account as verified.

Scenario: Going to my own "NGO" page
  Given I am on the “Login” page
  When I press the "I am a NGO" button
  Then I should see a set of different NGO buttons 
  When I press the "NGO Gebirah", button
  Then I should be redirected to the "NGO: Gebirah" page
  And I should see "Welcome Gebirah!"

Scenario: Retrieving undocumented user's EnableID personal particulars
  Given I am already on my "NGO: Gebirah" page
  When I key in the undocumented user's unique EnableID number: 1004209
  And I key in a 6 digit code that is seen on his/her EnableID: 837459
  And I press "Enter"
  Then I should be redirected to the "User Verification" page
  And I should see his/her "EnableID Card"
  And I should see a set of guidelines to properly verify an EnableID user
  And I should see a "Verified" Button

Scenario: Mark undocumented user's EnableID status as verified
  Given I am on the "User Verfication" page
  When I press the "Verify" button
  Then I should see "Successfully verified EnableID: 1004209!"
  Then I should be redirected to the "NGO: Gebirah" page

Scenario: Undocumented user's 1004209 EnableID verified checkmark
  Given that I am logged into user 1004209 EnableID account'
  Then I should see the checkmark on the user's EnableID card
  And I should see "EnableID - verified by NGO: Gebirah"
  And I should see "Date of verification: (today's date)"