ruby "2.4.0"
source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.4"
gem "bcrypt", "3.1.11"
gem "faker", "1.7.3"
gem "carrierwave", "1.1.0"
gem "mini_magick", "4.7.0"
gem "fog", "1.40.0"
gem "will_paginate", "3.1.5"
gem "bootstrap-will_paginate", "1.0.0"
gem "bootstrap-sass", "3.3.7"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "rubocop", require: false
gem "rubocop-checkstyle_formatter", require: false
gem "eslint-rails"
gem "therubyracer", platforms: :ruby

group :development, :test do
  gem "sqlite3"
  gem "byebug", platform: :mri
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "rails-controller-testing", "1.0.2"
  gem "minitest-reporters", "1.1.14"
  gem "guard", "2.14.1"
  gem "guard-minitest", "2.4.6"
end

group :production do
  gem "pg", "0.20.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
