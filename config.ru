require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
#if seperate Controllers for classes are made that have to to be activated with use here: examples below
      #use TweetController
      #use UserController
run ApplicationController
