Feature: User Uploading Documents
  As an undocumented individual
  I want to upload my documents during registration
  So that I can have a digital copy of my documents stored
  So that it will be accessible by me and NGO when needed

Background:
  Given I am an undocumented individual
  And I have completed the initial registration process
  And I need to upload my documents to complete my digital identity
  And I am now on the user particulars home page as a verified user
  Then I press the "Documents" button

Scenario: Going to "Upload Documents" page
  Then I should be directed to the "Upload Document" page

Scenario: Uploading a Document
  Given I am on the "Upload Document" page
  When I drag a document file into the designated drop area
  Then I should see the file name, file size, and date of upload
  And a new field should appear to describe the document added
  And a dropdown menu to select the type of document I am uploading should be displayed above the designated drop area
  And I should have an option to view and remove the document
  And the document should appear in the "Uploaded Documents" section to the right of the drop area

Scenario: Uploading an Unsupported File Type
  Given I am on the "Upload Document" page
  When I select a file with an unsupported format
  And drop the file
  Then I should see an error message stating "Unsupported file type. Please upload a PDF, DOC, DOCX, or JPG file."

Scenario: Uploading a File That Is Too Large
  Given I am on the "Upload Document" page
  When I select a file that exceeds the size limit
  And I drop the file
  Then I should see an error message stating "File size exceeds the maximum limit of 5MB. Please upload a smaller file."

Scenario: Previewing Uploaded Documents
  Given I am on the "Upload Document" page
  And I have uploaded a document
  When I click on the "Preview" button next to the uploaded document
  Then I should be able to preview the document in a new tab

Scenario: Categorizing Uploaded Documents
  Given I am on the "Upload Document" page
  And I have uploaded a document
  When I select an option from the dropdown menu to categorize the document
  Then the document should be categorized correctly with options "Education", "Medical", "Personal Documents", and "Property"

Scenario: Viewing Guide on Uploading Documents
  Given I am on the "Upload Document" page
  When I look at the top of the page
  Then I should see a guide on what to do on this page

Scenario: Verifying Uploaded Documents
  Given my document has been successfully uploaded and I have received confirmation
  When authorized personnel access my uploaded documents for verification
  Then they should only be able to do so with my consent and appropriate security checks
  And I should receive a notification that my documents are being reviewed

Scenario: Removing Uploaded Documents
  Given I am on the "Upload Document" page
  And I have uploaded a document
  When I click on the "Delete" button next to the uploaded document
  Then I should see a confirmation message
  And if I confirm the deletion, the document should be removed from the list

Scenario: Viewing No Files Message
  Given I am on the "Upload Document" page
  And I have not uploaded any documents
  Then I should see a message stating "No files uploaded yet."
