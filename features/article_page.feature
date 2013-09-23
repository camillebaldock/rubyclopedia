Feature: Article page
  In order to help the user choose articles he wants to and watch
  I want to give information about each article
  And how to get to them
  And if my user is authorised to have access to them or not

Scenario Outline: Publication date displayed on article page
	Given the date is "17/09/2013"
	And I have a free article published on "<published_date>"
	When I visit that article's page
	Then I should see "<text>"

	Examples:
		| published_date | text |
		| 16/09/2013 | 1 day ago |
		| 12/09/2013 | 5 days ago |
		| 17/08/2013 | 1 month ago|
		| 17/09/2012 | 1 year ago |
		| 17/09/2013 | today |

Scenario Outline: Core data displayed on article page
	Given I have a <paid> article
	When I visit that article's page
	Then I should see "<text>"
	Then I should see that article's "name"
	And I should see that article's "description"
	And I should see that article's "type"

 	Examples:
	 	| paid | text |
	 	| free | Available for free |
	 	| paid | Subscription needed |

Scenario Outline: Standard article page
	Given I have a <type> article from "<supplier>"
	When I visit that article's page
	Then I should see a "Go to article" link to that article's supplier page

	Examples:
		| type | supplier |
		| free | Rubytapas |
		| free | Railscasts |
		| paid | Railscasts |
		| free | Rubyrogues |

Scenario: Paid Rubytapas
	Given I have a paid article from "Rubytapas"
	When I visit that article's page
	Then I should see "If you have a paid subscription"
	And I should not see a "Go to article" link to that article's supplier page
