## Setup
### Prerequisites
- Ruby 2.5.3
- Rails 5.2.4.3

### Installation
#### Install gems and setup your database:
```
bundle install
rails db:create
rails db:migrate
```

#### Run your own development server:
```
rails s
```
- You should be able to send requests to the app via http://localhost:3000/
- This is only an API (no frontend view)

### Running the Tests
- Run with `bundle exec rspec`. All tests should be passing.
