ruby-casts-progress-tracker
===========================

Website to track progress on viewing Ruby training content, and getting the latest episodes from:

- RailsCasts
- RubyTapas
- RailsRogues
- Personal links from Kippt

This website has a log-in/sign-up system for users (with password reset functionality...)

Each episode can be:

- mark as watched
- added to my wishlist
- rated by each user
- rated by the superuser by difficulty

Episodes can be searched by:

- name
- category
- provider

Each user can make their wishlist public

This also provides an "offline" version that can be deployed at home, that handles downloading videos/tracks for all providers that support it

Current status
------------------------

Importers for RailsCasts, RubyTapas, RailsRogues and Kippt have been implemented.

Development plan
------------------------

The "online" version is to be developed and deployed as a priority.
The "offline" version will follow.

Stories to be completed
------------------------

### Must (minimum deployable subset)

##### Cron jobs to import all RailsCasts/RubyTapas/RailsRogues episodes
  * once per day, at 1am, 2am and 3am respectively

##### Home page
  * legal blurb to decline any claim of ownership for the content, or any responsibility for erroneous content etc...
  * link to Github..
  * number of episodes (total, and per provider)
  * last 5 episodes added
  * In Gherkin:

>Given I am on the home page

>And today is "17/09/2013"

>And I have the following episodes 

>| Name | Provider | Published date|

>| Recent RailsCasts episode | RailsCasts | 16/09/2013 |

>| Recent RubyRogues episode | RubyRogues | 15/09/2013 |

>| Recent RubyTapas episode | RubyTapas | 14/09/2013 |

>| Less recent RailsCasts episode | RailsCasts | 13/09/2013 |

>| Less recent RubyRogues episode | RubyRogues | 12/09/2013 |

>| Less recent RubyTapas episode | RubyTapas | 11/09/2013 |

>Then I should see "6 episodes"

>And I should see "2 RailsCasts episodes"

>And I should see "2 RubyTapas episodes"

>And I should see "2 RubyRogues episodes"

>And I should see "Recent RailsCasts episode"

>And I should not see "Less recent RubyTapas episode"

##### Find a good name
  * find a name for the website
  * register the domain

##### List page
 * Table of all episodes with name, published date and provider
 * In Gherkin:

>Given I am on the episodes page

>And today is "17/09/2013"

>And I have the following episodes 

>| Name | Provider | Published date |

>| Recent RailsCasts episode | RailsCasts | 16/09/2013 |

>| Less recent RubyTapas episode | RubyTapas | 11/09/2013 |

>Then I should see a table row containing | Recent RailsCasts episode | RailsCasts | 16/09/2013 |

>And I should see a table row containing | Less recent RubyTapas episode | RubyTapas | 11/09/2013 |

##### Episode page

* Published x days ago
* Name, description
* For RubyTapas and RailsCasts: display if subscription needed or not
* For RailsRogues and RailsCasts: go to episode page button
* For RubyTapas:
     - if free episode, QQ
     - if paid episode, display text: "If you have a paid subscription, you can log in to QQ and download the episode from {insert link here}"
* In Gherkin:

>Given I am on the episodes page

>And today is "17/09/2013"

>And I have the following episodes 

>| Name | Description | Provider | Published date| Free | Video link |

>| RailsCasts episode | RailsCasts description | RailsCasts | 16/09/2013 | true |
railscastslink |

>| RubyTapas episode | RubyTapas description | RubyTapas | 11/09/2013 | false | rubytapaslink |

>| Free RubyTapas episode | Free RubyTapas description | RubyTapas | 11/09/2013 | true | rubytapasfreelink |

>| RailsRogues episode | RailsRogues description | RailsRogues | 16/08/2013 | true | railsrogueslink |

Scenario: RailsCasts episode page
>When I follow "RailsCasts episode"

>Then I should see "RailsCasts episode", "RailsCasts description" and "1 day ago"

>And I should see "Free episode"

>And I should not see "Subscription needed"

>And I should see "Go to episode page" button that links to "railscastlink"

Scenario: RubyTapas episode page
>When I follow "RubyTapas episode"

>Then I should see "RubyTapas episode", "RubyTapas description" and "1 week ago"

>And I should not see "Free episode"

>And I should see "Subscription needed"

>And I should see "If you have a paid subscription QQ"

Scenario: RailsRogues episode page
>When I follow "RailsRogues episode"

>Then I should see "RailsRogues episode", "RailsRogues description" and "1 month ago"

>And I should not see "Free episode"

>And I should not see "Subscription needed"

>And I should see "Go to episode page" button that links to "railsrogueslink"


##### Google Analytics

##### Deployment (not necessary for the deployment, but a good source of material for training guide on deployment)
  * deploy on Heroku, and document
  * prepare Capistrano recipes for deployment on personal server, deploy successfully, and document
  * do a full Rubber deployment on AWS, deploy successfully, and document
  * do something cool with containers (Docker?), deploy and document
  * publish a gist with the result and concrete tutorial for the four approaches above

### Should

##### As a user, I can sign up for the system, log in, log out
* If I am not logged in, I only have access to:
     - the API without any Kippt data
     - the list of episodes (cannot mark as watched...)

##### Kippt episodes belong to users

##### Mark as watched (for logged in users)
##### Mark as favourite (for logged in users)

### Could

##### Investigate duration of videos possible for all providers (except Kippt)
##### Rate episodes
##### Some users can be superusers
##### Superusers can rate episodes by difficulty
##### Move settings from settings.yml to per-user settings in the database
##### Make a form for users to be able to change their settings
* The form should contain
   - Toggle button: Only display episodes I am allowed to view/Display all episodes
   - checkbox: are you a paying subscriber to RailsCasts
   - checkbox: are you a paying subscriber to RubyTapas
   - input-text: public URL for your Kippt feed (client-side regex validation (looks like a URL), server-side validation (this URL can be reached and the content looks like a Kippt feed))

### Would

##### Other Ruby training resources to be included
##### Gamification aspect
##### Subscribe to several Kippt public feeds, give each feed a name