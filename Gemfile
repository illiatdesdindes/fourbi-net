# Edit this Gemfile to bundle your application's dependencies.
source 'http://gemcutter.org'

gem 'rails', '3.0.0.beta2'

## Bundle edge rails:
# gem "rails", :git => "git://github.com/rails/rails.git"

# ActiveRecord requires a database adapter. By default,
# Rails has selected sqlite3.

## Bundle the gems you use:
# gem "bj"
# gem "hpricot", "0.6"
# gem "sqlite3-ruby", :require => "sqlite3"
# gem "aws-s3", :require => "aws/s3"

## Bundle gems used only in certain environments:
# gem "rspec", :group => :test
# group :test do
#   gem "webrat"
# end

gem 'haml', '2.2.22'
gem 'email_veracity', '0.5.0', :require => 'email_veracity'
gem 'andand', '1.3.1'
gem 'will_paginate', '3.0.pre', :require => 'will_paginate'
gem 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git', :branch => 'rails3'
gem 'rest-client', '1.4.2', :require => 'rest_client'

group :development do
  gem 'bullet', '2.0.0.beta.2'
  gem 'ruby-growl', '1.0.1'
  gem 'pg'
end

group :production do
  gem 'hassle', '0.0.1'
end