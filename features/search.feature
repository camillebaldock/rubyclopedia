@javascript
Feature: Search
  As a User
  I want to search for content
  In order to find content easily over paginating

  Background:
   Given I am on the home page

  Scenario: Find articles by content
    Given the following articles exist:
      | name             |
      | Demon in a Bottle |
      | Extremis          |
    When I search for "Demon"
    Then I should see "Demon in a Bottle"
    But I should not see "Extremis"

  Scenario: No articles found
    When I search for "Armor Wars"
    Then I should see a message indicating no articles were found