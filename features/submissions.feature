Feature: Submissions
  In order for the Rubyclopedia to keep expanding
  Users can submit articles
  And the administrator can accept or reject them

Scenario: If a user is not logged in, he cannot see the submission link
  When I go to the home page
  Then I should not see "Submit an article"

Scenario: If a user is not logged in, he cannot submit
  When I go to the new submissions page
  Then I should see "Sign in"

Scenario: If a user is not logged in, he can see the submission link
  Given that a user exists
  And I am logged in
  When I go to the home page
  Then I should see "Submit an article"

Scenario: Refuse submissions with wrong parameters
  Given that a user exists
  And I am logged in
  And I go to the new submissions page
  And I fill in "submission[url]" with "url"
  And I press "Create Submission"
  Then I should see "1 error prohibited this proposed article from being sent"

Scenario: Successful submission
  Given that a user exists
  And I am logged in
  And I go to the new submissions page
  And I fill in "submission[url]" with "url"
  And I fill in "submission[description]" with "description"
  And I press "Create Submission"
  Then I should see my profile