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
                              elsif !params[:age].to_i.is_a? Integer
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
                                redirect "/consumers/#{@consumer.id}"
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
#binding.pry

        #librarians can view all consumer account info
        #consumers cannot see an account unless they are logged in
        #consumers cannot see account info unless it is their own via session
                      if session.has_key?("librarian_id")
                                    @consumer = Consumer.find_by(id: params[:id])
                                    @library = Library.find_by(id: @consumer.library_id)
                                    erb :'/consumers/show'
                      elsif session.has_key?("consumer_id")
                            @consumer = Consumer.find_by(id: params[:id]) #browser input
                            if session[:consumer_id] == @consumer.id      #does logged in user match the profile they want  to look at?
                                    @library = Library.find_by(id: @consumer.library_id)
                                    erb :'/consumers/show'
                            else
                                redirect "/consumers/#{session[:consumer_id]}"
                            end
                      else
                            redirect "/login"
                      end
            end
            #only the consumer can edit their own information
            get '/consumers/:id/edit' do
#binding.pry
                  if consumer_logged_in?
                      @consumer = Consumer.find_by(id: params[:id])
                      if session[:consumer_id] == @consumer.id
                          @library = Library.find_by(id: @consumer.library_id)
#binding.pry
                          erb :'/consumers/edit'

                      else
                        #if the signed in user does not match the edit page they are trying to get to, they will be redirected to their own show page
                          redirect "/consumers/#{session[:consumer_id]}"
                      end
                  else
                      redirect "/consumers/#{params[:id]}"
                  end
            end
            patch '/consumers/:id' do
    #          binding.pry
                  @consumer = Consumer.find_by(id: params[:id])
                  @consumer.update(name: params[:name],
                                    username: params[:username],
                                    age: params[:age],
                                    address: params[:address],
                                    email: params[:email],
                                    library_id: params[:library_id])
                              #above method can be written  with a neater hash nested under a consumer key in the patch form
                  @consumer.save

                  flash[:message] = "Successfully updated consumer profile."
                  redirect("/consumers/#{@consumer.id}")
            end

end


#
