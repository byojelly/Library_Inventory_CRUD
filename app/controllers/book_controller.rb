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


end


# =>      if params[:name]=="" || params[:age]=="" || params[:start_year]=="" || params[:username]==""  || params[:address]==""  || params[:email]==""
# =>              flash[:message] = "Please do not leave the input sections empty when submiting an edit."
# =>              redirect "/librarians/#{session[:librarian_id]}/edit"
# =>      elsif !is_number?(params[:age]) || !is_number?(params[:start_year])
# =>              flash[:message] = "Please make sure that your age and first year of employment is numerical."
# =>              redirect "/librarians/#{session[:librarian_id]}/edit"
# =>      elsif !params.has_key?("library_id")
# =>            flash[:message] = "Please make sure that you select a library."
# =>            redirect "/librarians/#{session[:librarian_id]}/edit"
# =>      else
#
#patch '/consumers/:id' do
##          binding.pry
#      @consumer = Consumer.find_by(id: params[:id])
#      @consumer.update(name: params[:name],
#                        username: params[:username],
#                        age: params[:age],
#                        address: params[:address],
#                        email: params[:email],
#                        library_id: params[:library_id])
#                  #above method can be written  with a neater hash nested under a consumer key in the patch form
#      @consumer.save
#
#      flash[:message] = "Successfully updated consumer profile."
#      redirect("/consumers/#{@consumer.id}")
#end


#if librarian_logged_in?
#      @librarian = Librarian.find_by(id: params[:id]) #browser input
#      if session[:librarian_id] == @librarian.id      #does logged n user match the profile they want  to look at?
#              @library = Library.find_by(id: @librarian.library_id)
#              erb :'/librarians/show'
#      else
#          redirect "/librarians/#{session[:librarian_id]}"
#      end
#else
#      redirect "/login"
#      flash[:message] = "Librarians may only view their own personal profile."
#end
