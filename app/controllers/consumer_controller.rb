require './config/environment'
require 'rack-flash'
class ConsumerController < HelperController

    use Rack::Flash

    post '/consumers/onboarding' do
binding.pry

    end

end


#
