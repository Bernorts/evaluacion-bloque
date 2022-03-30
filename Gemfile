# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '4.3.12'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Google Closure Compiler as compressor for ES6 JavaScript assets
gem 'closure-compiler'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
#

# gem 'execjs' 
# gem 'therubyracer'

gem 'aws-sdk', '~> 2.3.0'
gem 'byebug'
gem 'haml'
gem 'paperclip', '~> 5.0'
gem 'redis', '~> 3.3'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'redis-namespace'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt'

gem 'simple_form'

gem 'dotenv-rails', require: 'dotenv/rails-now'

gem 'rdiscount'

gem 'git_stats'

# gem 'resque'
# gem 'resque-web', require: 'resque_web'

gem 'sidekiq'

gem 'faker' # This gem should be later put only in development and test

gem 'axlsx', '= 2.0.1'
gem 'axlsx_rails'
gem 'chartkick'
gem 'groupdate'
gem 'rubyzip', '= 1.0.0'
gem 'uglifier'

group :development, :test do
  gem 'factory_girl_rails'
  gem 'pry'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # gem 'happy_seed'
  gem 'letter_opener'

  gem 'brakeman', require: false
  gem 'rubocop', require: false

  gem 'capistrano',         require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano3-puma',   require: false

  #   # Use Capistrano for deployment
  #   gem 'capistrano', '~> 3.8', require: false, group: :development
  #   # Deploy with capistrano, see config/deploy.rb
  #   gem 'capistrano-rails', '~> 1.1', require: false
  #   gem 'capistrano-bundler', '~> 1.1', require: false
  #   gem 'capistrano-safe-deploy-to', '~> 1.1.1', require: false
  #   gem 'rvm1-capistrano3', '~> 1.3.2', require: false
  #   gem 'capistrano-postgresql', '~> 4.2.1', require: false
  #   # gem 'capistrano-memcached', '~> 1.2.0', require: false
  #   gem 'capistrano3-puma',  require:false
  #   # gem 'capistrano-faster-assets', '~> 1.0.2', require: false
  #   gem 'capistrano-sidekiq', require: false
  #   gem 'capistrano-crono'
end

group :test do
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'vcr'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

gem 'bh'
gem 'bootstrap', '~> 4.0.0.beta'
gem 'ckeditor'
gem 'dateslices'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.2'
gem 'github_webhook', '~> 1.0.2'
gem 'gretel'
gem 'meta-tags', require: 'meta_tags'
gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f'
gem 'modernizr-rails'
gem 'momentjs-rails'
gem 'nokogiri'
gem 'octokit'
gem 'premailer-rails'
gem 'rails-assets-datatables', source: 'https://rails-assets.org'
gem 'rails-assets-jquery', source: 'https://rails-assets.org'
gem 'rails-i18n'
gem 'responders', '~> 2.0'
gem 'sweetalert-rails'
gem 'turbolinks', '~> 5.0.0'
ruby '2.5.5'
