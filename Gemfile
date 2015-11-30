source 'https://rubygems.org'

ruby "2.0.0"

gem 'mysql2', '~> 0.3.18'

group :development, :test do

  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem "rails-erd"

  gem 'capistrano',           require: false
  gem 'capistrano-rvm',       require: false
  gem 'capistrano-rails',     require: false
  gem 'capistrano-bundler',   require: false
  #gem 'capistrano-passenger', require: false
  gem 'capistrano3-puma',     require: false

end

group :production do
  gem 'rails_12factor', '0.0.2'
  gem 'thin'
  gem 'puma'
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#bootstrap
gem 'bootstrap-sass', '~> 3.3.4.1'

gem 'rails_admin', '~> 0.6.8'


gem 'nokogiri', '~> 1.6.6.2'

gem 'mechanize', '~> 2.7.3'

gem 'rake-progressbar', '~> 0.0.5'

gem "better_errors"

#for user authentication 
gem "devise"

gem 'execjs'

gem 'therubyracer', :platforms => :ruby

gem 'paper_trail', '~> 4.0'

gem 'diffy'