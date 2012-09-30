source "https://rubygems.org"

gem "rails"
gem "thin"
gem "rack-cors", require: "rack/cors"
gem "will_paginate"
gem "thumbs_up"
gem "faraday"
gem "multi_json"
gem "oj"

group :production do
  gem "pg"
end

group :development, :test do
  gem "sqlite3"
  gem "debugger"
end

group :test do
  gem "foreman"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "simplecov", require: false
end
