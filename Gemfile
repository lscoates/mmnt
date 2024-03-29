source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'rails', '7.0.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3.9'
gem 'jsbundling-rails'
gem 'jbuilder', '~> 2.7'
gem 'devise'
gem 'aws-sdk-s3', require: false
gem 'sprockets-rails'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem 'active_storage_validations', '< 1.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'pry', '~> 0.13.1'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  # gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'shoulda-matchers'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "hotwire-rails", "~> 0.1.3"

# Use Redis for Action Cable
gem "redis", "~> 4.0"

gem "cssbundling-rails", "~> 1.1"

gem "tailwindcss-rails", "~> 2.0"
