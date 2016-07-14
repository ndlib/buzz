source "https://rubygems.org"

gem "hesburgh_infrastructure", github: "ndlib/hesburgh_infrastructure"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.0.0"

gem "pg"

# Use Puma as the app server
gem "puma", "~> 3.0"

# Use Capistrano for deployment
gem "capistrano-rails", group: :development
gem "coveralls", require: false

# Server monitoring
gem "newrelic_rpm"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platform: :mri
  gem "rspec-rails"
  gem "guard"
  gem "guard-rails"
  gem "guard-rspec"
  gem "guard-zeus"

  gem "rubocop"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
