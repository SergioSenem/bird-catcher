# Bird Catcher

Bird Catcher is a rails web application that follows tweets with hashtags inserted by it's users.

[Web site published on Heroku](https://bird-catcher.herokuapp.com/)

User: Admin 

Password: senha@123

## Ruby and Rails versions
* Ruby version 2.6.5
* Rails version 6.0.2.1

## Gems dependencies

* gem 'pg'
* gem 'bcrypt'
* gem 'twitter'
* gem 'crono'
* gem 'bootstrap'
* gem 'jquery-rails'

## Twitter API

This applicatios uses the Twitter API, that means that if you want to run this application, you will need a twitter developer account. With a twitter developer account, create a file "twitter.env" inside the root directory of the application, inside it put your credentials like in the example:

```
consumer_key        = "YOUR_TWITTER_CONSUMER_KEY"
consumer_secret     = "YOUR_TWITTER_CONSUMER_SECRET"
access_token        = "YOUR_TWITTER_ACCESS_TOKEN"
access_token_secret = "YOUR_TWITTER_ACCESS_SECRET" 
```

## Getting started

* Clone the repository
* Run 'bundle install' inside the application root directory
```
bundle install
```
* Run 'rails db:migrate' to create database
```
rails db:migrate
```
* Run 'rails db:seed' to populate users database with user Admin (Password: senha@123)
```
rails db:seed
```
* Run 'rails s' to run the server in localhost:3000/
```
rails s
```
* To keep the application searching for tweets, open another console window and run 'bundle exec crono'
```
bundle exec crono
```

## Executing tests

To run the application tests, run 'rake test'
```
rake test
```

## ApplicationJob

The application has a Application Job that, thanks to crono, every 5 minutes search for new tweets with the hashtags inserted by the users. That keeps the application database updated without stressing the Twitter API.

But, to not keep the user waiting for the Job next execution, after a hashtag insert, the application executes the search, populating the hashtag with the initial tweets.
