require './config/environment'
require 'rack-flash'
class LibraryController < HelperController

    use Rack::Flash

    #libraries all page is homepage
    get '/libraries' do
        redirect '/'
    end
    get '/libraries/new' do
          if librarian_logged_in?
              erb :'/libraries/new'
          else
            redirect '/login'
          end
    end
#not putting a lot of validations to save time
    post  '/libraries/new' do
binding.pry
          if params[:name]=="" || params[:contact_phone]=="" || params[:contact_email]=="" || params[:address_street]=="" || params[:address_city]=="" || params[:address_state]=="" || params[:address_zipcode]=="" || params[:hours_of_operation]==""
                  flash[:message] = "Please do not leave input fields empty."
                  redirect '/libraries/new'
          else
              @library = Library.create(name: params[:name], contact_phone: params[:contact_phone], contact_email: params[:contact_email], address_street: params[:address_street], address_city: params[:address_city], address_state: params[:address_state], address_zipcode: params[:address_zipcode], hours_of_operation: params[:hours_of_operation])

              redirect redirect "/libraries/#{@library.id}"
          end
    end

# =>                    post '/signup' do
# =>                #binding.pry
# =>                        #lets do some signup validations
# =>                                    #make sure, (only 1 user is selected), and that (both buttons arent left blank)
# =>                                  if (params.has_key?("consumer") && params.has_key?("librarian")) || (!params.has_key?("consumer") && !params.has_key?("librarian"))
# =>                                    flash[:message] = "Please select either Consumer or Librarian as a usertype. Not both."
# =>                                      redirect '/signup'
# =>                                    #make sure username, email and password arent blank
# =>                                  elsif params[:username]=="" || params[:email]=="" || params[:password]==""
# =>                                    flash[:message] = "Please do not leave username/email/password empty."
# =>                                      redirect '/signup'
# =>                                    #if the consumer was checked
# =>                                  elsif params.has_key?("consumer")
# =>                                        #error if the user already exists
# =>                                        if !!Consumer.find_by(username: params[:username])
# =>                                                flash[:message] = "This Consumer username has already been taken. Please makeup a new username."
# =>                                                redirect to '/signup'
# =>                                        #if user doesnt exist create Consumer
# =>                                        else
# =>                                            @consumer = Consumer.create(username: params[:username], email: params[:email], password: params[:password])
# =>                                            session[:consumer_id] = @consumer.id
# =>                #binding.pry
# =>                                            erb :'/consumers/onboarding'
# =>                                        end
# =>                                    #if librarian was checked
# =>                                  elsif params.has_key?("librarian")
# =>                                          #see if username exists
# =>                                        if !!Librarian.find_by(username: params[:username])
# =>                                                flash[:message] = "This Librarian username has already been taken. Please makeup a new username."
# =>                                                redirect to '/signup'
# =>                                        else
# =>                                          #if username doesnt exist create Librarian
# =>                                            @librarian = Librarian.create(username: params[:username], email: params[:email], password: params[:password])
# =>                                            session[:librarian_id] = @librarian.id
# =>                #binding.pry
# =>                                            erb :'/librarians/onboarding'
# =>                                        end
# =>
# =>                                  end
# =>
# =>
# =>                     end












    get '/libraries/:id' do

          @library = Library.find_by(id: params[:id])
          @librarians= Librarian.all
          @consumers = Consumer.all

          @librarian_array =   @librarians.collect do |l|
                               l.library_id == params[:id].to_i
                                end
          @librarian_count = @librarian_array.count(true)
          @consumer_array =   @consumers.collect do |c|
                                   c.library_id == params[:id].to_i
                                end
          @consumer_count = @consumer_array.count(true)
#binding.pry
          erb :'/libraries/show'

    end

end
