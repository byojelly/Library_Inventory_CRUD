require './config/environment'
require 'rack-flash'
class BookController < HelperController

    use Rack::Flash

    #libraries all page is homepage

    get '/books/:id' do

        @book = Book.find_by(id: params[:id])
#binding.pry
        erb :'/books/show'
    end
    get '/books/:id/edit' do
#binding.pry
          if logged_in?
              if consumer_logged_in?
                  redirect "/books/#{params[:id]}"
              else
                  @librarian = Librarian.find_by(id: session[:librarian_id])
                  @book = Book.find_by(id: params[:id])
                  erb :'/books/edit'
              end
          else
              redirect '/login'
          end
    end
    patch '/books/:id' do
#binding.pry
          if   params[:name]=="" || params[:author]=="" || params[:pages]=="" || params[:available]==""
                  flash[:message] = "Please do not leave the input sections empty when submiting an edit."
                  redirect "/books/#{params[:id]}/edit"
          elsif !is_number?(params[:pages])
                  flash[:message] = "Please ensure that the pages input is numerical."
                  redirect "/books/#{params[:id]}/edit"
    #      elsif

          else
                  @book = Book.find_by(id: params[:id])
                  @book.update( name: params[:name],
                                author: params[:author],
                                pages: params[:pages],
                                available: params[:available],
                                library_id: params[:library_id],
                                section_id: params[:section_id])
                  @book.save
                  flash[:message] = "Successfully updated book profile."
                  redirect("/books/#{@book.id}")
          end
    end
    post '/books/new' do
#unable params does not yield the library id form the urls
#binding.pry
              if   params[:name]=="" || params[:author]=="" || params[:pages]=="" || params[:available]==""
                    flash[:message] = "Please do not leave the input sections empty when submiting an edit."
                    redirect "/libraries/#{@library.id}/books/new"

              elsif !is_number?(params[:pages])
                      flash[:message] = "Please ensure that the pages input is numerical."
                      redirect "/libraries/#{@library.id}/books/new"
              elsif params.has_key?("y") && params.has_key?("n")
                      flash[:message] = "Please only select yes or no for availability."
                      redirect "/libraries/#{@library.id}/books/new"
              elsif !params.has_key?("y") && !params.has_key?("n")
                      flash[:message] = "Please select yes or no for availability."
                      redirect "/libraries/#{@library.id}/books/new"
              else
#binding.pry
                        @book = Book.create(name: params[:name], author: params[:author], pages: params[:pages], available: params[:available], library_id: params[:library_id], section_id: params[:section_id])
                        redirect "/books/#{@book.id}"
              end
    end


end
