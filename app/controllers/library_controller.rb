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
    get '/libraries/:id/edit' do
#binding.pry
              if librarian_logged_in?
                  @library = Library.find_by(id: params[:id])
                  @librarian = Librarian.find_by(id: params[:id])
#binding.pry
                  erb :'/libraries/edit'
              else
                redirect '/login'
              end
    end


#not using many validations for sake of time
    patch '/libraries/:id' do

            @library = Library.find_by(id: params[:id])
#binding.pry
            if params[:name]=="" || params[:contact_phone]=="" || params[:contact_email]=="" || params[:address_street]=="" || params[:address_city]=="" || params[:address_state]=="" || params[:address_zipcode]=="" || params[:hours_of_operation]==""
                  flash[:message] = "Please do not leave input fields empty."
                  redirect "/libraries/#{params[:id]}/edit"
            else
                @library.update(name: params[:name], contact_phone: params[:contact_phone], contact_email: params[:contact_email], address_street: params[:address_street], address_city: params[:address_city], address_state: params[:address_state], address_zipcode: params[:address_zipcode], hours_of_operation: params[:hours_of_operation])
                @library.save
                flash[:message] = "Successfully updated library profile."
                redirect   "/libraries/#{@library.id}"
            end
    end
# =>              patch '/librarians/:id' do
# =>          #binding.pry
# =>                        @librarian = Librarian.find_by(id: params[:id])
# =>                        if params[:name]=="" || params[:age]=="" || params[:start_year]=="" || params[:username]==""  || params[:address]==""  || params[:email]==""
# =>                                flash[:message] = "Please do not leave the input sections empty when submiting an edit."
# =>                                redirect "/librarians/#{session[:librarian_id]}/edit"
# =>                        elsif !is_number?(params[:age]) || !is_number?(params[:start_year])
# =>                                flash[:message] = "Please make sure that your age and first year of employment is numerical."
# =>                                redirect "/librarians/#{session[:librarian_id]}/edit"
# =>                        elsif !params.has_key?("library_id")
# =>                              flash[:message] = "Please make sure that you select a library."
# =>                              redirect "/librarians/#{session[:librarian_id]}/edit"
# =>                        else
# =>                                  @librarian.update(name: params[:name],
# =>                                                    username: params[:username],
# =>                                                    age: params[:age],
# =>                                                    start_year: params[:start_year],
# =>                                                    email: params[:email],
# =>                                                    library_id: params[:library_id])
# =>                                              #above method can be written  with a neater hash nested under a consumer key in the patch form
# =>                                  @librarian.save
# =>                                  flash[:message] = "Successfully updated consumer profile."
# =>                                  redirect("/librarians/#{@librarian.id}")
# =>                        end
# =>              end
end
