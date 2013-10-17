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
	 	| free | Free |
	 	| paid | Paid |

Scenario Outline: Link on article page
	Given I have a <type> article from "<supplier>" of type "<medium>"
	When I visit that article's page
	Then I should see a "<link>" link to that article's supplier page

	Examples:
		| type | supplier    | link | medium |
		| free | Rubytapas   | Go to video | Video |
		| paid | Rubytapas   | Download | Video |
		| free | Railscasts  | Go to video | Video |
		| paid | Railscasts  | Go to video | Video |
		| free | Rubyrogues  | Go to audio | Audio |
		| free | Codecademy  | Go to course | Course |
		| free | Codeschool  | Go to course | Course |
		| paid | Codeschool  | Go to course | Course |
		| free | Envylabs    | Go to audio | Audio |
		| paid | Pluralsight | Go to course | Course |
