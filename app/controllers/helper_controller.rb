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
          !!session[:consumer_id] || !!session[:librarian_id]
      end
      def consumer_logged_in?
          !!session[:consumer_id]
      end
      def librarian_logged_in?
          !!session[:librarian_id]
      end
      def current_user
        Librarian.find_by(id: session[:librarian_id]) || Consumer.find_by(id: session[:consumer_id])
      end
    end


end


#
