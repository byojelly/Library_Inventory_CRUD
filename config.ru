require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#the code above was previously the code below on 12/10/18. Had to be modified to overcome error
#if ActiveRecord::Migrator.needs_migration?
#  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
#end

use Rack::MethodOverride

use SectionController
use BookController
use LibraryController
use UserController
run ApplicationController
