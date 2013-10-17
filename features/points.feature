Feature: Points
  In order to encourage users to use and contribute to the Rubyclopedia
  I want to give points to users for watching/favouriting resources
  And I want to give points to users for submitting articles

Background: User logged in
  Given that a user exists
  And I am logged in

Scenario Outline: Points for marking articles
  Given I have a article
  And I visit that article's page
  And I click "<mark>"
  Then I should have "<point>" points
  
  Examples:
    | mark | point |
    | Mark as viewed | 1 |
    | Mark as favourite | 1 |

Scenario: Points for unmarking article as favourite
  Given I have a article
  And I have marked this article as favourite
  And I visit that article's page
  And I click "Unmark as favourite"
  Then I should have "-1" points

Scenario: Points for unmarking article as viewed
  Given I have a article
  And I have marked this article as viewed
  And I visit that article's page
  And I click "Unmark as viewed"
  Then I should have "-1" points

Scenario: Points for a submission
  Given I go to the new submissions page
  And I fill in "submission[url]" with "url"
  And I fill in "submission[description]" with "description"
  And I press "Create Submission"
  Then I should have "10" points