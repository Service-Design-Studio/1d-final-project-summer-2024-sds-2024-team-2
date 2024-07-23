Given('I am already on NGO "Gebirah" verify a user page') do
  step 'I am on the "Login" page'
  step 'I press the "I am a NGO" button'
  step 'I press the NGO "Gebirah" card'
  step 'I key in the Unique ID: \'3665753" and 6 digit code 2FA: "310263", then I press the check button'
  step 'I should be redirected to the User Verification page under "Gebirah"'
  step 'I should see his/her EnableID card'
  step 'I should see "3665753"'
  step 'I should see "Verify" button'
end
