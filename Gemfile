source 'https://rubygems.org'

gem 'rails', '3.2.0'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'mongoid', '~> 3.1.6'

gem 'bson_ext'

gem "tweetstream"


group :development, :test do
  gem 'sqlite3' #heroku hates sqlite
  gem 'rspec-rails', '~> 2.0'
  gem 'capybara', '~> 2.0.2'
end

group :production do
  # gems specifically for Heroku go here
  gem "pg" #for heroku
end

ruby '2.0.0' #for heroku
