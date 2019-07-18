source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'fast_jsonapi'
gem 'bcrypt', '~> 3.1', '>= 3.1.13'
gem 'jwt'
gem 'will_paginate', '~> 3.1', '>= 3.1.7'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
end

group :test do
  gem 'factory_bot_rails', '~> 5.0', '>= 5.0.2'
  gem 'shoulda-matchers', '~> 4.1', '>= 4.1.1'
  gem 'faker', '~> 1.9', '>= 1.9.6'
  gem 'database_cleaner', '~> 1.7'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
