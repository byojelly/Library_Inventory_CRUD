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
#binding.pry
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
          @books = Book.all
#binding.pry
          @librarian_array =   @librarians.collect do |l|
                               l.library_id == params[:id].to_i
                                end
          @librarian_count = @librarian_array.count(true)
          @consumer_array =   @consumers.collect do |c|
                                   c.library_id == params[:id].to_i
                                end
          @consumer_count = @consumer_array.count(true)
          @books_array =   @books.collect do |c|
                                   c.library_id == params[:id].to_i
                                end
          @books_count = @books_array.count(true)
#binding.pry
          erb :'/libraries/show'

    end
    get '/libraries/:id/edit' do
#binding.pry
              if librarian_logged_in?
                  @library = Library.find_by(id: params[:id])
                  @librarian = Librarian.find_by(id: params[:id])
                  @books = Book.all
                  @books_array =   @books.collect do |c|
                                           c.library_id == params[:id].to_i
                                        end
                  @books_count = @books_array.count(true)
#binding.pry

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
    get '/libraries/:id/books'  do

            @library = Library.find_by(id: params[:id])
            @books = Book.all.select {|x| x.library_id==params[:id].to_i}
            @books_count = @books.count
#binding.pry
            erb :'/books/show_all'
    end
    get '/libraries/:id/books/new'  do
#binding.pry
          if  logged_in?
              if librarian_logged_in?
                    @library = Library.find_by(id: params[:id])
                    erb :'/books/new'
              else
                    redirect '/'
              end
          else
            redirect '/login'
          end
    end
    get '/libraries/:id/sections/:section_id' do

          @library = Library.find_by(id: params[:id])
          @section = Section.find_by(id: params[:section_id])
#binding.pry
          erb :"/sections/show"
    end

end
