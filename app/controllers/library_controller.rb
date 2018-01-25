require './config/environment'
require 'rack-flash'
class LibraryController < HelperController

    use Rack::Flash
  
end
