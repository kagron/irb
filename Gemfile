source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'delayed_job_active_record'
gem 'sprockets-rails'
# use will-paginate for paginations
gem 'will_paginate-bootstrap'
# Use Searchkick to link ruby on rails with Elasticsearch more efficiently
gem "searchkick"
# Use font awesome for icons
gem "font-awesome-rails"
# Use Whenever for scheduling rake tasks without using crontab
gem 'whenever', require: false
#install cancan gem for roles
gem 'cancancan'
# Use redcarpet for markdown parsing
gem 'redcarpet', '~> 3.3', '>= 3.3.4'
#install remotipart
gem 'remotipart', github: 'mshibuya/remotipart'
#install rails admin
gem 'rails_admin', '~> 1.3.0'
# Use Hirb for better irb console
gem 'hirb', '~> 0.7.3'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use jquery-ui for autocomplete feature
gem 'jquery-ui-rails'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use CarrierWave for attachments
gem 'carrierwave', '~> 1.0'
# Use Bootstrap for styling
gem 'bootstrap-sass', '3.3.7'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'will_paginate', '~> 3.1.0'
# Use Prawn for pdf generation, specifically the stamp
gem 'prawn'
# Use combine_pdf for putting the stamp on every pdf
gem 'combine_pdf'
# Use Yomu for reading doc and docx
gem 'yomu'
# I dont think pdfkit is actually used
# gem 'pdfkit'
# gem 'wkhtmltopdf-binary'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use devise for users
gem 'devise'

# this needs to be in here for some reason
gem 'jquery-turbolinks'

# I dont know what this does tbh
gem 'rb-readline'
