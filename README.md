In 1 minute, get your Rails app with Foursquare running on Heroku.

For now, it's only available when you create a new Rails app from scratch (but if you look at the code, you should be able to make it work for existing apps too).

To create a new app with Foursquare and deploy to Heroku, run:

> rails new {your-unique-app-name} -m https://raw.github.com/gist/4007411/e0580f5e0db6bc91d3e329ecfb8b78580d858865/gistfile1.rb

Note: try to make sure {your-unique-app-name} is unique or Heroku won't let you create an app with a name that's already taken.