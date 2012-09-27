source "https://rubygems.org"

gem "rails"
gem "thin"
gem "rack-cors", require: "rack/cors"

group :production do
  gem "pg"
end

group :development, :test do
  gem "sqlite3"
end

group :test do
  gem "foreman"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "simplecov", require: false
end
