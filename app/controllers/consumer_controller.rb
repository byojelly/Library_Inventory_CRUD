require './config/environment'
require 'rack-flash'
class ConsumerController < HelperController

    use Rack::Flash

    post '/consumers/onboarding' do
      @consumer = Consumer.find_by(id: session[:consumer_id])
#binding.pry
                if params.has_key?("library_id")
                      if params[:name]=="" || params[:age]=="" || params[:address]==""
                              flash[:message] = "Please do not leave name/age/address empty during onboarding."
                              erb :'/consumers/onboarding'
                      elsif !params[:age].is_a? Integer
                              flash[:message] = "Please make sure that your age input is numerical."
                              erb :'/consumers/onboarding'
                      else
                        @consumer.name = params[:name]
                        @consumer.age = params[:age]
                        @consumer.address = params[:address]
                        @consumer.library_id = params[:library_id]
                        @library = Library.find_by(id: @consumer.library_id)
                        @library.consumers << @consumer
                        @consumer.save
                        redirect "/consumers/<%=@consumer.id%>/"
                      end
                else
                flash[:message] = "Please try again. You must select a local library during the onboarding."
                  erb :'/consumers/onboarding'
                end
    end
    get '/consumers/all' do
#this is a view for librarians to view all consumers per library.
#should recognize a librarian is logged in
#if a consumer is logged in it should redirect to /consumers/:id
    end
    get '/consumers/:id' do

        @consumer = Consumer.find_by(id: session[:consumer_id])
        @library = Library.find_by(id: @consumer.library_id)
binding.pry
        erb :'/consumers/show'
    end

end


#
