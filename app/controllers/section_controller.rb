require './config/environment'
require 'rack-flash'
class SectionController < HelperController

    use Rack::Flash

    get '/sections' do
binding.pry
       @sections = Section.all
       return "code here later"
    end




end



# =>            get '/books/:id' do
# =>
# =>                @book = Book.find_by(id: params[:id])
# =>            #binding.pry
# =>                erb :'/books/show'
# =>            end
# =>            get '/books/:id/edit' do
# =>            #binding.pry
# =>                  if logged_in?
# =>                      if consumer_logged_in?
# =>                          redirect "/books/#{params[:id]}"
# =>                      else
# =>                          @librarian = Librarian.find_by(id: session[:librarian_id])
# =>                          @book = Book.find_by(id: params[:id])
# =>                          erb :'/books/edit'
# =>                      end
# =>                  else
# =>                      redirect '/login'
# =>                  end
# =>            end
# =>            patch '/books/:id' do
# =>            #binding.pry
# =>                  if   params[:name]=="" || params[:author]=="" || params[:pages]=="" || params[:available]==""
# =>                          flash[:message] = "Please do not leave the input sections empty when submiting an edit."
# =>                          redirect "/books/#{params[:id]}/edit"
# =>                  elsif !is_number?(params[:pages])
# =>                          flash[:message] = "Please ensure that the pages input is numerical."
# =>                          redirect "/books/#{params[:id]}/edit"
# =>            #      elsif
# =>
# =>                  else
# =>                          @book = Book.find_by(id: params[:id])
# =>                          @book.update( name: params[:name],
# =>                                        author: params[:author],
# =>                                        pages: params[:pages],
# =>                                        available: params[:available],
# =>                                        library_id: params[:library_id],
# =>                                        section_id: params[:section_id])
# =>                          @book.save
# =>                          flash[:message] = "Successfully updated book profile."
# =>                          redirect("/books/#{@book.id}")
# =>                  end
# =>            end
