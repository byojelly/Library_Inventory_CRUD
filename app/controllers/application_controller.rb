require './config/environment'
require 'rack-flash'
class ApplicationController < HelperController

    use Rack::Flash

    get '/' do
#binding.pry
        @libraries = Library.all
         erb :homepage
    end
    get '/login' do
        erb :login
    end
    get '/signup' do
#binding.pry
        erb :signup
    end

    post '/signup' do
#binding.pry
        #lets do some signup validations
                    #make sure, (only 1 user is selected), and that (both buttons arent left blank)
                  if (params.has_key?("consumer") && params.has_key?("librarian")) || (!params.has_key?("consumer") && !params.has_key?("librarian"))
                    flash[:message] = "Please select either Consumer or Librarian as a usertype. Not both."
                      redirect '/signup'
                    #make sure username, email and password arent blank
                  elsif params[:username]=="" || params[:email]=="" || params[:password]==""
                    flash[:message] = "Please do not leave username/email/password empty."
                      redirect '/signup'
                    #if the consumer was checked
                  elsif params.has_key?("consumer")
                        #error if the user already exists
                        if !!Consumer.find_by(username: params[:username])
                                flash[:message] = "This Consumer username has already been taken. Please makeup a new username."
                                redirect to '/signup'
                        #if user doesnt exist create Consumer
                        else
                            @consumer = Consumer.create(username: params[:username], email: params[:email], password: params[:password])
                            session[:consumer_id] = @consumer.id
        #binding.pry
                            erb :'/consumers/onboarding'
                        end
                    #if librarian was checked
                  elsif params.has_key?("librarian")
                          #see if username exists
                        if !!Librarian.find_by(username: params[:username])
                                flash[:message] = "This Librarian username has already been taken. Please makeup a new username."
                                redirect to '/signup'
                        else
                          #if username doesnt exist create Librarian
                            @librarianLibrarian.create(username: params[:username], email: params[:email], password: params[:password])
                          #  erb :'/librarians/onboarding'
                        end

                  end


     end
     get '/logout' do
       session.clear
       redirect to "/login"
     end



end


#
