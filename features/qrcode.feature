Feature: QR code on EnableID card

Background:
    Given I am now on the user particulars home page as a verified user

Scenario: Viewing the QR code (back of the card)
    Given the Digital ID is showing my information
    When I press on the "QR code" icon button
    Then I should see a unique QR code
    When I press on the "card" icon button
    Then I should see a unique my information













 