require './config/environment'
require 'rack-flash'
class ApplicationController < HelperController

    use Rack::Flash

  
end


#
