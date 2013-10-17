Feature: Article annotation
  In order for users to know which resources they have used
  I want to mark articles as watched or unwatched
  And I want to mark articles as favourites or unfavourite
  And I want to mark articles as part of my wishlist or not

Background: User logged in
  Given that a user exists
  And I am logged in

Scenario: Mark as viewed
  Given I have a article
  When I visit that article's page
  And I click "Mark as viewed"
  Then I should see "Unmark as viewed"
  And I should see "You viewed"

Scenario: Mark as unviewed
  Given I have a article
  And I have marked this article as viewed
  When I visit that article's page
  And I click "Unmark as viewed"
  Then I should see "Mark as viewed"
  And I should see "Unviewed"

Scenario: Mark as favourite
  Given I have a article
  When I visit that article's page
  And I click "Mark as favourite"
  Then I should see "Unmark as favourite"
  And I should see "You favourited"

Scenario: Mark as unfavourite
  Given I have a article
  And I have marked this article as favourite
  When I visit that article's page
  And I click "Unmark as favourite"
  Then I should see "Mark as favourite"
  And I should see "Unfavourited"

