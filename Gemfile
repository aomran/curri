source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby "2.1.1"
gem 'rails', '>= 4.0.0'
gem 'pg'

group :production do
  gem 'rails_12factor'
  gem 'appsignal'
end

group :development, :test do
  gem 'minitest-rails-capybara'
  gem 'minitest-colorize'
  gem 'pry-rails'
  gem "mocha", :require => false
  gem "teaspoon"
  gem 'bullet'
  gem 'selenium-webdriver'
end

group :development do
  gem 'brakeman', :require => false
  gem 'better_errors'
  gem 'rails_best_practices'
  gem 'spring'
  gem 'style-guide'
  gem 'rack-livereload'
  gem 'guard-livereload'
end

gem 'newrelic_rpm'
gem 'email_validator'
gem 'bcrypt-ruby'
gem 'foreman'
gem 'pusher'
gem 'acts_as_list'
gem 'unicorn'
gem 'delayed_job_active_record'
gem "hirefire-resource"
gem "mail_view", "~> 1.0.3"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Assets
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pickadate-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development