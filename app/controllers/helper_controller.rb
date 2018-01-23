require './config/environment'
require 'rack-flash'
class HelperController < Sinatra::Base

    use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
        enable :sessions                    #sets sessions
        set :session_secret, "password_security"

  end

    helpers do
      def logged_in?
          !!session[:user_id]
      end
      def current_user
        Librarian.find_by(id: session[:library_id])
      end
    end


end


#
