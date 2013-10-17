Feature: Home page
  In order to attract more people to this website
  I want to give statistics about the variety and quantity of articles available
  And display the latest additions

Background:
	Given the date is "17/09/2013"
	And the following articles exist:
	| name | supplier | published_at | medium |
	| Recent RailsCasts episode | Railscasts | 16/09/2013 | Video |
	| Recent RubyRogues episode | Rubyrogues | 15/09/2013 | Video |
	| Recent RubyTapas episode | Rubytapas | 14/09/2013 | Video |
	| Less recent RailsCasts episode | Railscasts | 13/09/2013 | Video |
	| Less recent RubyRogues episode | Rubyrogues | 12/09/2013 | Video |
	| Less recent RubyTapas episode | Rubytapas | 11/09/2013 | Video |
	When I go to the home page

Scenario: Display total number of articles
	Then I should see "6 entries"

Scenario: Display names of 5 most recent articles
	Then I should see the following:
	| Recent RailsCasts episode |
	| Recent RubyRogues episode |
	| Recent RubyTapas episode |
	| Less recent RailsCasts episode |
	| Less recent RubyRogues episode |
    And I should not see "Less recent RubyTapas episode"