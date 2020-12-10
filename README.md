
[![Build Status](https://travis-ci.com/Oxalisviolacea/viewing_party.svg?branch=main)](https://travis-ci.com/Oxalisviolacea/viewing_party)
# Viewing Party

This is the base repo for the [viewing party project](https://backend.turing.io/module3/projects/viewing_party) used for Turing's Backend Module 3.

### About this Project
Viewing party is an application in which users can explore movie options and create a viewing party event for the user and friend's. You can check out our site [here](https://friends-viewing-party.herokuapp.com)!  
<img src="https://github.com/Oxalisviolacea/viewing_party/blob/main/images/Viewing%20Party%20Gif.gif" width="550" height="450">
## Contributors
- Hanna Davis  
   [Github](https://github.com/Oxalisviolacea) | [LinkedIn](https://www.linkedin.com/in/hanna-davis/)
- Philip DeFraties  
    [Github](https://github.com/philipdefraties) | [LinkedIn](https://www.linkedin.com/in/philip-defraties-4232681b6/)
- Greg Mitchell  
   [Github](https://github.com/GregJMitchell) | [LinkedIn](https://www.linkedin.com/in/gregory-j-mitchell/)

## Schema
<img src="https://github.com/Oxalisviolacea/viewing_party/blob/main/images/Viewing%20Party%20Schema.jpg" width="450" height="350">  

## Built With
- Ruby on Rails
- JQuery  

## Important Gems:
[faraday](https://github.com/lostisland/faraday)
[webmock](https://github.com/bblimke/webmock)
[vcr](https://github.com/vcr/vcr)
[figaro](https://github.com/laserlemon/figaro)
[travis](https://docs.travis-ci.com/user/languages/ruby/)

## Getting Started
1. Get an api key from [The Movie Database API](https://developers.themoviedb.org/3/getting-started/authentication)
1. Fork and clone the repo
2. Install any missing gems from gem file
3. Install gem packages with `bundle install`
4. Setup the database with `rails db:{create,migrate,seed}`
5. In config/application.ymal paste:
`MOVIEDB_API_KEY: "<YOUR API KEY>"`
Replace <YOUR API KEY> with the key you obtained from The Movie Database API.
6. From your terminal run `$ rails s` and navigate to http://localhost:3000/ in your browser to navigate the app
7. To run our test suite, RSpec, enter `bundle exec rspec` in the terminal. (All 97 tests should be passing)

## Future Changes
1. Full CRUD functionality for users, parties, and friendships
2. Utilize Actionmailer to send viewing party event details to users.
3. Implement Chat functionality with ActionCable
4. Deploy to a different service other than Heroku

## Additonal References
- [Base Respository](https://backend.turing.io/module3/projects/viewing_party) used for Turing's Backend Module 3.
- [Wire Frames](https://backend.turing.io/module3/projects/viewing_party/wireframes)
- [API Documentation](https://developers.themoviedb.org/3/getting-started/authentication)
