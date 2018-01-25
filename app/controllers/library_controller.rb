require './config/environment'
require 'rack-flash'
class LibraryController < HelperController

    use Rack::Flash
    get '/libraries' do
binding.pry
    end
end
