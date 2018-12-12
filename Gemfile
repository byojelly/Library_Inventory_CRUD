source 'http://rubygems.org'

gem 'sinatra'
#Sinatra is a DSL (domain specific language) for quickly creating web applications in Ruby with minimal effort:
gem 'activerecord', :require => 'active_record'
#Databases on Rails. Build a persistent domain model by mapping database tables to Ruby classes. Strong conventions for associations, validations, aggregations, migrations, and testing come baked-in.
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'  #allows our modules to easily interact with database and pre wrtiten code
gem 'rake'  #allows us to interact with rake commands for db etc
#Rake is a Make-like program implemented in Ruby. Tasks and dependencies are specified in standard Ruby syntax. Rake has the following features: * Rakefiles (rake's version of Makefiles) are completely defined in standard Ruby syntax. No XML files to edit. No quirky Makefile syntax to worry about (is that a tab or a space?) * Users can specify tasks with prerequisites. * Rake supports rule patterns to synthesize implicit tasks. * Flexible FileLists that act like arrays but know abouT manipulating file names and paths. * Supports parallel execution of tasks.
gem 'require_all'
#A wonderfully simple way to load your code
gem 'sqlite3'  #sets up our database
#This module allows Ruby programs to interface with the SQLite3 database engine (http://www.sqlite.org). You must have the SQLite engine installed in order to build this module. Note that this module is only compatible with SQLite 3.6.16 or newer.
gem 'thin'
#A thin and fast web server
gem 'shotgun'  #real time viewing of our code in a browser
gem 'pry' #binding.pry
gem 'bcrypt'
#bcrypt() is a sophisticated and secure hash algorithm designed by The OpenBSD project for hashing passwords. The bcrypt Ruby gem provides a simple wrapper for safely handling passwords.
#passwords are hashed and saved into the db
gem "tux"
#another way of viewing our code (databses specifically) in terminal similar to a binding.pry or irb
gem 'rack-flash3'
#Flash hash implementation for Rack apps.
group :test do
  gem 'rspec'
  #BehaviorDrivenDevelpment for Ruby
  gem 'capybara'
  #Capybara is an integration testing tool for rack based web applications. It simulates how a user would interact with a website
  #test case execution
  gem 'rack-test'
  #gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
