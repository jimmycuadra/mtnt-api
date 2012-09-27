source "https://rubygems.org"

gem 'rails'

# Server
gem 'thin'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
end

group :test do
  gem 'foreman'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'simplecov', require: false
end
