require './config/environment'
require 'rack-flash'
class LibraryController < ApplicationController

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
          if params[:library][:name]=="" || params[:library][:contact_phone]=="" || params[:library][:contact_email]=="" || params[:library][:address_street]=="" || params[:library][:address_city]=="" || params[:library][:address_state]=="" || params[:library][:address_zipcode]=="" || params[:library][:hours_of_operation]==""
                  flash[:message] = "Please do not leave input fields empty."
                  redirect '/libraries/new'
          else
              @library = Library.create(params[:library])
              redirect redirect "/libraries/#{@library.id}"
          end
    end

    get '/libraries/:id' do
        #  session.delete("library_id")  #used to close the section create loop for dynamic routes in post request for new and delete requests
          @library = Library.find_by(id: params[:id])
          @librarians= librarians_array
          @consumers = consumers_array
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
          if logged_in?
                    if librarian_logged_in?
                        @library = Library.find_by(id: params[:id])
                        @librarian = User.find_by(id: session[:user_id])
                        @books = Book.all
                        @books_array =   @books.collect do |c|
                                                 c.library_id == params[:id].to_i
                                              end
                        @books_count = @books_array.count(true)
      #binding.pry

      #binding.pry
                        erb :'/libraries/edit'
                    elsif consumer_logged_in?
                      redirect "/consumers/#{params[:user_id]}"
                    else
                      redirect '/login'
                    end
          else
                redirect '/login'
          end
    end


#not using many validations for sake of time
    patch '/libraries/:id' do

            @library = Library.find_by(id: params[:id])
#binding.pry
            if params[:library][:name]=="" || params[:library][:contact_phone]=="" || params[:library][:contact_email]=="" || params[:library][:address_street]=="" || params[:library][:address_city]=="" || params[:library][:address_state]=="" || params[:library][:address_zipcode]=="" || params[:library][:hours_of_operation]==""
                  flash[:message] = "Please do not leave input fields empty."
                  redirect "/libraries/#{params[:id]}/edit"
            else
                @library.update(params[:library])
                flash[:message] = "Successfully updated library profile."
                redirect   "/libraries/#{@library.id}"
            end
    end
    get '/libraries/:id/delete' do
#binding.pry
                if librarian_logged_in?
                  @library = Library.find_by(id: params[:id])
                  erb :"/libraries/delete"
                else
                    redirect '/'
                end
    end
    delete '/libraries/:id' do
#binding.pry

        @library = Library.delete(params[:id])
        redirect "/"

    end


    get '/libraries/:id/books'  do

            @library = Library.find_by(id: params[:id])
            @books = Book.all.select {|x| x.library_id==params[:id].to_i}
            @books_count = @books.count
#binding.pry
            erb :'/books/show_all'
    end
    get '/libraries/:id/books/new'  do
binding.pry
#posts request comes from book controller
          if  logged_in?
              if librarian_logged_in?
                    @library = Library.find_by(id: params[:id])

                    session[:library_id] = @library.id
                    erb :'/books/new'
              else
                    redirect '/'
              end
          else
            redirect '/login'
          end
    end
    get '/libraries/:id/sections/new' do
#binding.pry

            session.delete("library_id")    #a session param is added when creating a new section for dynamic routes in post request. The deletion allows the ability for the session added to not persist outside teh creation of the section
            if  logged_in?
                if librarian_logged_in?
                    #  @section = nil
                      @library = Library.find_by(id: params[:id])
          #below is work around to allow the post parameter to get additional information for creating a new sections
                      @next_section_id = Section.count + 1

                      session[:library_id] = @library.id  #allows our post request to use the id to redirect the route

#binding.pry
                        erb :'/sections/new'
                else
                      redirect '/'
                end
            else
              redirect '/login'
            end

          #post request will come from SectionController
    end
    get '/libraries/:id/sections/:section_id' do
          session.delete("library_id")  #used to close the section create loop for dynamic routes in post request
          @library = Library.find_by(id: params[:id])
          @section = Section.find_by(id: params[:section_id])

          erb :"/sections/show"
    end
    get '/libraries/:id/sections/:section_id/edit' do
          @librarian = User.find_by(id: session[:user_id])
          @library = Library.find_by(id: params[:id])
          @section = Section.find_by(id: params[:section_id])

#binding.pry
          erb :"/sections/edit"
    end
    get '/libraries/:id/sections/:section_id/delete' do
#binding.pry
             #full loop with to allow dynamic redirecting routing in the delete request
          @librarian = User.find_by(id: session[:user_id])
          @library = Library.find_by(id: params[:id])
          @section = Section.find_by(id: params[:section_id])
          session[:library_id] = @library.id
          erb :"/sections/delete"
    end


end
