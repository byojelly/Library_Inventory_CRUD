require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
        enable :sessions                    #sets sessions
        set :session_secret, "password_security"

  end

    get '/' do
#binding.pry
         # erb :index

    end

    helpers do
      def logged_in?
          !!session[:user_id]
      end
      def current_user
        User.find_by(id: session[:user_id])
      end
    end


end


# =>        rspec spec/controllers/application_controller_spec.rb
