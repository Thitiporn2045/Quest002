Feature: Brag

    As a User 
    I want to see brag
    So that I can see brag

    Background: 
        Given website contain all necessary data

    Scenario: I should see brag
        Given I am currently at homepage
        Then I should see "THITIPORN THAIMJAN" that is opening
        And I should see a button with text "View Brag"
        When I click the "View Brag"
        Then I should see "My 2025 Goals"
