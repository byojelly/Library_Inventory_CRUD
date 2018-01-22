source 'http://rubygems.org'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'  #allows our modules to easily interact with database and pre wrtiten code
gem 'rake'  #allows us to interact with rake commands for db etc
gem 'require_all'
gem 'sqlite3'  #sets up our database
gem 'thin'
gem 'shotgun'  #real time viewing of our code in a browser
gem 'pry'
gem 'bcrypt'  #allows us to secure passwords in our database safely
gem "tux"       #another way of viewing our code (databses specifically) in terminal similar to a binding.pry or irb
gem 'rack-flash3'  

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
