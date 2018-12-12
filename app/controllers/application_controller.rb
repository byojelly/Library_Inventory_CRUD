require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base

#set up sessions via bcrypt
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
                def consumer_logged_in?
                      User.find(session[:user_id]).librarian == false
                end
                def librarian_logged_in?
                    User.find(session[:user_id]).librarian == true
                end
                def current_user
                    User.find(session[:user_id])
                end
                def is_number?(string)
                  true if Float(string) rescue false
                end
                def librarians_array
                    @librarians = []
                    User.all.each do |u|
                                  if u[:librarian] == true
                                    @librarians << u
                                  end
                    end
                    @librarians
                end
                def consumers_array
                  @consumers = []
                  User.all.each do |u|
                                if u[:librarian] == false
                                  @consumers << u
                                end
                  end
                  @consumers
                end
      end
    get '/' do
#get homepage
          #session.delete("librarian_id")
          session.delete("library_id")  #used to close the section create loop for dynamic routes in post request
          @libraries = Library.all
           erb :homepage  #render this ruby code to the html homepage page
    end
    get '/signup' do
#binding.pry

        if logged_in?
              if consumer_logged_in?
                redirect "/consumers/#{session[:user_id]}"
              else
              #  binding.pry
                redirect "/librarians/#{session[:user_id]}"
              end
        else
              erb :signup
        end
    end

    post '/signup' do
#binding.pry
        #lets do some signup validations
                    #make sure button is not left blank
                  if !params[:user].has_key?("librarian")
                        flash[:message] = "Please select either Consumer or Librarian as a usertype. Not both."
                          redirect '/signup'
                        #make sure username, email and password arent blank
                  elsif params[:user][:username]=="" || params[:user][:email]=="" || params[:user][:password]==""
                        flash[:message] = "Please do not leave username/email/password empty."
                          redirect '/signup'
                        #if the consumer was checked
                  elsif params[:user][:librarian] == "false"
                            #error if the user already exists
                            if !!User.find_by(username: params[:user][:username])
                                    flash[:message] = "This username has already been taken. Please makeup a new username (perhaps your email)."
                                    redirect to '/signup'
                            #if user doesnt exist create Consumer
                            else
                                @user_consumer = User.create(params[:user])
                                session[:user_id] = @user_consumer.id
    #binding.pry
                                erb :'/users/consumers/onboarding'
                            end
                        #if librarian was checked
                  elsif params[:user][:librarian] == "true"

                                  #see if username exists
                                if !!User.find_by(username: params[:user][:username])
                                        flash[:message] = "This username has already been taken. Please makeup a new username (perhaps your email)."
                                        redirect to '/signup'
                                else
                                  #if username doesnt exist create Librarian
                                    @user_librarian = User.create(params[:user])
                                    session[:user_id] = @user_librarian.id
        #binding.pry
                                    erb :'/users/librarians/onboarding'
                                end
                  end
     end
     get '/login' do
        if logged_in?
              if consumer_logged_in?
                redirect "/consumers/#{session[:user_id]}"
              else
              #  binding.pry
                  redirect "/librarians/#{session[:user_id]}"
              end
        else
              erb :login
        end
     end
     post '/login' do
#binding.pry
              if   params[:user][:username]=="" ||  params[:user][:password]==""
                      flash[:message] = "Please do not leave username/password blank when logging in."
                      redirect to '/login'
              else
                      if    !params[:user].has_key?("librarian")
                                  flash[:message] = "Please select either consumer or librarian id type when logging in."
                                  redirect to '/login'

                      elsif !!params[:user][:librarian] == false
                              @consumer = User.find_by(username: params[:user][:username])
                              if @consumer && @consumer.authenticate(params[:user][:password])
                                session[:user_id] = @consumer.id
                                redirect "/consumers/#{@consumer.id}"
                              else
                                flash[:message] = "Your username/password does not match our records. Please double check and try logging in again."
                                redirect to '/login'
                              end
                      elsif !!params[:user][:librarian] == true
                              @librarian = User.find_by(username: params[:user][:username])
                              if @librarian && @librarian.authenticate(params[:user][:password])
                                session[:user_id] = @librarian.id
                                redirect "/librarians/#{@librarian.id}"
                              else
                                flash[:message] = "Your username/password does not match our records. Please double check and try logging in again."
                                redirect to '/login'
                              end
                      end
              end
     end
     get '/logout' do
       session.clear
       redirect to "/login"

       #get should only get POST SHOULD ONLY POST
       #get requests should not be be making changes to the server
       #google how to change a method with a link, i want to change the logout link to submit a post request to logout post request
     end

end
