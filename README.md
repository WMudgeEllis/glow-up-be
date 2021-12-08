# GlowUp Back End Application

This is the back end repository for the project glow up. The front repo is [here](https://github.com/bullet-capstone/glow-up-fe). This repository is responsible for storing and serving data to the front end application which handles the presentation of data.

The base url for the production server is https://glowup-be.herokuapp.com/

If you would like to visit our front-end production environment, you can access it [here](https://bullet-capstone.github.io/glow-up-fe/)

### Schema

![Screen Shot 2021-12-08 at 1 56 33 PM](https://user-images.githubusercontent.com/84806907/145283660-625b735b-7ddb-430a-88ad-84797ff6ab5b.png)

### Ruby/Rails versions

  - Ruby 2.7.2
  - Rails 5.2.6

### Gem Documentation:

  -  [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
  -  [pry](https://github.com/pry/pry)
  -  [simplecov](https://github.com/simplecov-ruby/simplecov)
  -  [factory_bot](https://github.com/thoughtbot/factory_bot)
  -  [faker](https://github.com/faker-ruby/faker)
  -  [graphql](https://graphql.org/)

### Languages:
![ActiveRecord](https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=flaste&logo=rubyonrails&logoColor=white)
![Ruby](https://img.shields.io/badge/Ruby-CC0000.svg?&style=flaste&logo=ruby&logoColor=white)

### Deployment Tools:
![Heroku](https://img.shields.io/badge/Heroku-430098.svg?&style=flaste&logo=heroku&logoColor=white)
![GitHub Actions](https://github.com/bullet-capstone/glow-up-be/actions/workflows/ci.yml/badge.svg)

#### Development Principles
<p>
  <img src="https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white" />
  <img src="https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white" />
</p>


### Deployment instructions

  ```
  git clone git@github.com:bullet-capstone/glow-up-be.git

  bundle install

  rails db:{create,migrate,seed}

  ```


### How to run the test suite

  `bundle exec rspec`
