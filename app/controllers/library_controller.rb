require './config/environment'
require 'rack-flash'
class LibraryController < HelperController

    use Rack::Flash

    #libraries all page is homepage
    get '/libraries' do
        redirect '/'
    end
    get '/libraries/new' do
binding.pry
          if librarian_logged_in?
              erb :'/libraries/new'
          else
            redirect '/login'
          end
    end

#    post '/librarians/new' do
#
#    end
#    @librarian = Librarian.find_by(id: session[:librarian_id])
##binding.pry
#      if params.has_key?("library_id")
#            if params[:name]=="" || params[:age]=="" || params[:start_year]==""
#                    flash[:message] = "Please do not leave name/age/first year empty during onboarding."
#                    erb :'/librarians/onboarding'
#            elsif !is_number?(params[:age])
#                    flash[:message] = "Please make sure that your age is numerical."
#                    erb :'/librarians/onboarding'
#
#            elsif !is_number?(params[:start_year])
#                            flash[:message] = "Please make sure that your first year worked input is numerical."
#                            erb :'/librarians/onboarding'
#            else
#              @librarian.name = params[:name]
#
#              @librarian.age = params[:age].to_i
#              @librarian.start_year = params[:start_year].to_i
#              @librarian.library_id = params[:library_id].to_i
#              @library = Library.find_by(id: @librarian.library_id)
#
#              @library.librarians << @librarian
#              @librarian.save
#              redirect "/librarians/#{@librarian.id}"
#            end
#      else
#      flash[:message] = "Please try again. You must select a local library during the onboarding."
#        erb :'/librarians/onboarding'
#      end
#
#
#
#












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
