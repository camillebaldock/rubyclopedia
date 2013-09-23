rubyclopedia
===========================

Website to get he latest articles from the following suppliers, and track progress on viewing Ruby training content:

- RailsCasts
- RubyTapas
- RubyRogues
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

Development plan
------------------------

The "online" version is to be developed and deployed as a priority as a minimal usable subset. 
User login and functionality to track progress in following release. 
The "offline" version will follow after that. 

Stories to be completed
------------------------

### Must (minimum deployable subset)

##### Elastic search fulltext search functionality for front page, on name and description fields

##### Deployment (not necessary for the deployment, but a good source of material for training guide on deployment)
  * deploy on Heroku, and document
  * prepare Capistrano recipes for deployment on personal server, deploy successfully, and document
  * do a full Rubber deployment on AWS, deploy successfully, and document
  * do something cool with containers (Docker?), deploy and document
  * publish a gist with the result and concrete tutorial for the four approaches above
  * whenever --set environment=production

### Should

##### Error handling and deduplication on feed parsing
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

##### Other Ruby training resources to be included (http://ruby5.envylabs.com/ for example)
##### Gamification aspect
##### Subscribe to several Kippt public feeds, give each feed a name