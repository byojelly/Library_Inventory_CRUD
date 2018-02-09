require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use SectionController
use BookController
use LibraryController
#use LibrarianController
#use ConsumerController
use UserController
run ApplicationController
#run HelperController
