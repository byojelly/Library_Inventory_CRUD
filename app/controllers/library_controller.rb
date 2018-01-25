require './config/environment'
require 'rack-flash'
class LibraryController < HelperController

    use Rack::Flash
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
