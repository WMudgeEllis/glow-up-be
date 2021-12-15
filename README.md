![](https://img.shields.io/badge/Ruby-2.7.2-red)![](https://img.shields.io/badge/Rails-5.2.6-red)![GitHub Actions](https://github.com/bullet-capstone/glow-up-be/actions/workflows/ci.yml/badge.svg)![Heroku](https://img.shields.io/badge/Heroku-430098.svg?&style=flaste&logo=heroku&logoColor=white) ![](https://img.shields.io/badge/-GraphQL-blue)

# [GlowUp](https://bullet-capstone.github.io/glow-up-fe/) Back End Application

This is the back-end application repository for [GlowUp](https://bullet-capstone.github.io/glow-up-fe/).
The front-end repository can be found [here](https://github.com/bullet-capstone/glow-up-fe).



### Primary Technologies

  - Ruby 2.7.2
  - Rails 5.2.6
  - PostgreSQL
  - [GraphQL](https://graphql.org/)
  - [RSpec](https://rspec.info/)

### Local Set-Up

`git clone git@github.com:bullet-capstone/glow-up-be.git`

`bundle install`

`rails db:{create,migrate,seed}`


### Testing

Testing is done with [RSpec](https://rspec.info/) with coverage details provided by [SimpleCov](https://github.com/simplecov-ruby/simplecov).

#### Test Suite Execution

`bundle exec rspec`

#### Integrations
  -  [Pry](https://github.com/pry/pry)
  -  [Faker](https://github.com/faker-ruby/faker)
  -  [FactoryBot](https://github.com/thoughtbot/factory_bot)
  -  [Shoulda-Matchers](https://github.com/thoughtbot/shoulda-matchers)

### GraphQL Playground

GraphQL queries are fully interactive in the development environment using [GraphiQL](https://github.com/graphql/graphiql).

Initialize your development server and navigate to `localhost:3001/graphiql` to view and execute available queries and mutations.

### Database Design

![Screen Shot 2021-12-08 at 1 56 33 PM](https://user-images.githubusercontent.com/84806907/145283660-625b735b-7ddb-430a-88ad-84797ff6ab5b.png)

### Contributors

- Tanner Dale [LinkedIn](https://www.linkedin.com/in/tannerdale/) [GitHub](https://github.com/TannerDale)
- Weston Ellis [LinkedIn](https://www.linkedin.com/in/weston-mudge-ellis/) [GitHub](https://github.com/WMudgeEllis/)
