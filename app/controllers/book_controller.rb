require './config/environment'
require 'rack-flash'
class BookController < ApplicationController

    use Rack::Flash

    #libraries all page is homepage

    get '/books/:id' do
#binding.pry
        if logged_in?
              if librarian_logged_in?
                @book = Book.find_by(id: params[:id])
                @librarian = User.find_by(id: session[:user_id])
                @library = Library.find_by(id: @librarian.library_id)
                @section = Section.find_by(id: @book.section_id)
              elsif consumer_logged_in?
                @book = Book.find_by(id: params[:id])
                @consumer = User.find_by(id: session[:user_id])
                @library = Library.find_by(id: @consumer.library_id)
                @section = Section.find_by(id: @book.section_id)
              end
        else
              redirect "/login"

        end
      #  @library = session[:library]
      #  session.delete("library_id")
#binding.pry
        erb :'/books/show'
    end
    get '/books/:id/edit' do
#binding.pry

          if logged_in?
              if consumer_logged_in?
                  redirect "/books/#{params[:id]}"
              elsif librarian_logged_in?
                  @librarian = User.find_by(id: session[:user_id])
                  @book = Book.find_by(id: params[:id])
                  erb :'/books/edit'
              end
          else
              redirect '/login'
          end
    end
    post '/books/new' do
#binding.pry
#unable params does not yield the library id form the urls
#binding.pry
              if   params[:book][:name]=="" || params[:book][:author]=="" || params[:book][:pages]==""
                    flash[:message] = "Please do not leave the input sections empty when submiting an edit."
                    redirect "/libraries/#{session[:library_id]}/books/new"

              elsif !is_number?(params[:book][:pages])
                      flash[:message] = "Please ensure that the pages input is numerical."
                      redirect "/libraries/#{session[:library_id]}/books/new"


              else
#binding.pry
                        @book = Book.create(params[:book])
                        @book.available = "y"
                        @book.library_id = session[:library_id]
                        @book.save
                        redirect "/books/#{@book.id}"
              end
    end

    patch '/books/:id' do
#binding.pry
          if   params[:book][:name]=="" || params[:book][:author]=="" || params[:book][:pages]=="" || params[:book][:available]==""
                  flash[:message] = "Please do not leave the input sections empty when submiting an edit."
                  redirect "/books/#{params[:id]}/edit"
          elsif !is_number?(params[:book][:pages])
                  flash[:message] = "Please ensure that the pages input is numerical."
                  redirect "/books/#{params[:id]}/edit"
    #      elsif
#corrcect all redirect pages done so far
          else
                  @book = Book.find_by(id: params[:id])
                  @book.update(params[:book])
                  flash[:message] = "Successfully updated book profile."
                  redirect("/books/#{@book.id}")
          end
    end
    get '/books/:id/delete' do

          @book = Book.find_by(id: params[:id])
              if librarian_logged_in?
  #  binding.pry
                erb :"/books/delete"
              else
                  redirect("/books/#{@book.id}")
              end
    end
    delete '/books/:id' do
#binding.pry
      @library_id = Book.find_by(id: params[:id]).library_id
      @section_id = Book.find_by(id: params[:id]).section_id
      @book = Book.delete(params[:id])
      redirect "/libraries/#{@library_id}/sections/#{@section_id}"  # http://localhost:9393/libraries/2/sections/2
    end


end
