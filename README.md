# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
3.1.1
* System dependencies
check Gemfile
* Configuration if you were to start up a 2 app react rails project from scratch.

first `rails new <app_name> --database=postgresql -T --api`

add gem 'rspec-rails', gem 'net-smtp', uncomment rack-cors and bcrypt 

## Gemfile
group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers'
end

change this file and add this to rails_helper.rb
### spec/rails_helper.rb
```# configure shoulda matchers to use rspec as the test framework and full matcher libraries for rails
Shoulda::Matchers.configure do |config|
 config.integrate do |with|
   with.test_framework :rspec
   with.library :rails
 end
end
# ...

RSpec.configure do |config|
  # ...
  # add `FactoryBot` methods
  config.include FactoryBot::Syntax::Methods
  # start by truncating all the tables but then use the faster transaction strategy the rest of the time.
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end
  # start the transaction strategy as examples are run
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
  # ...
end
```

change application_controller.rb

```
# application_controller.rb
class ApplicationController < ActionController::Base
```

change config/application.rb

```
config.middleware.use ActionDispatch::Cookies    config.middleware.use ActionDispatch::Session::CookieStore
```

change `config.api_only = true` to `config.api_only = false`

create two files config/initializers/cookie_serializer.rb and config/initializers/session_store.rb

```
#config/initializers/cookie_serailizer.rb
Rails.application.config.action_dispatch.cookies_serializer = :hybrid
```
```
#config/initializers/session_store.rb
if Rails.env === 'production' 
    Rails.application.config.session_store :cookie_store, key: '_name-of-your-app', domain: 'name-of-you-app-json-api'
  else
    Rails.application.config.session_store :cookie_store, key: '_name-of-your-app'
end

Rails.application.config.session_store :cookie_store, {
  :key => '_your_app_name',
  :domain => :all,
  :same_site => :none,
  :secure => :true,
  :tld_length => 2
}
```
then we go to config/intializers/cors.rb

```
#config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do 
  allow do
    origins 'http://localhost:3000'
  
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
```
then last we go to config/puma.rb
```
#config/puma.rb
# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port        ENV.fetch("PORT") { 3001 }
```

* Database creation
`rails db:create`
* Database initialization
`rails db:migrate`
* How to run the test suite
`rspec` remember to change .rspec file and add --format documentation to get clear tests
Tips on tests to write:
 - validations of username (including presence and uniqueness, and length)
 - validations of password (including presence and length of)
 - registration and authentication test with username or password is incorrect start with describe 'POST /register' do and use have_http_status(:created) and have_http_status(:unauthorized)
* Architecture (tips on how to create)
  - validate models after tests
  - form proper routes for test
  - create proper errors and errors raised for authentication controller
  - create representers folder and services folder for the user controller and check both ruby files for how to create them.
  - the representer is how the json will be outputted onto the screen. 
  - the services is how the JWT is going to be generated.
* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
