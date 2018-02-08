require './config/environment'
require 'rack-flash'
class ConsumerController < ApplicationController

    use Rack::Flash

  #          post '/consumers/onboarding' do
  #            @consumer = Consumer.find_by(id: session[:consumer_id])
            ##binding.pry
  #                      if params[:consumer].has_key?("library_id")
  #                            if params[:consumer][:name]=="" || params[:age]=="" || params[:consumer][:address]==""
  #                                    flash[:message] = "Please do not leave name/age/address empty during onboarding."
  #                                    erb :'/consumers/onboarding'
  #                            elsif !is_number?(params[:consumer][:age])  #helper method
  #                                    flash[:message] = "Please make sure that your age input is numerical."
  #                                    erb :'/consumers/onboarding'
  #                            else
  #                              @consumer.update(params[:consumer])
  #                              @library = Library.find_by(id: @consumer.library_id)
  #                              @library.consumers << @consumer
  #                              @consumer.save
            #binding.pry
  #                              redirect "/consumers/#{@consumer.id}"
  #                            end
  #                      else
  #                      flash[:message] = "Please try again. You must select a local library during the onboarding."
  #                        erb :'/consumers/onboarding'
  #                      end
  #          end
  #          get '/consumers' do
#b#inding.pry
  #                    if librarian_logged_in?
  #                        @consumers = Consumer.all
  #                        @librarian = Librarian.find_by(id: session[:librarian_id])
  #                        erb :"/consumers/show_all"
  #                    elsif consumer_logged_in?
  #                        @consumer = Consumer.find_by(id: session[:consumer_id])
  #                        redirect "/consumers/#{@consumer.id}"
  #                    else
  #                        redirect "/login"
  #                    end
  #      #this is a view for librarians to view all consumers per library.
  #      #should recognize a librarian is logged in
  #      #if a consumer is logged in it should redirect to /consumers/:id
  #          end
#            get '/consumers/:id' do
##binding.pry
#
#        #librarians can view all consumer account info
#        #consumers cannot see an account unless they are logged in
#        #consumers cannot see account info unless it is their own via session
#                      if librarian_logged_in? #helper
#                                    @consumer = Consumer.find_by(id: params[:id])
#                                    @library = Library.find_by(id: @consumer.library_id)
#                                    erb :'/consumers/show'
#                      elsif consumer_logged_in? #helper
#                            @consumer = Consumer.find_by(id: params[:id]) #browser input
#                            if session[:consumer_id] == @consumer.id      #does logged in user match the profile they want  to look at?
#                                    @library = Library.find_by(id: @consumer.library_id)
#                                    erb :'/consumers/show'
#                            else
#                                redirect "/consumers/#{session[:consumer_id]}"
#                            end
#                      else
#                            redirect "/login"
#                      end
#            end
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
                  elsif librarian_logged_in?
                      @librarian = Librarian.find_by(id: session[:librarian_id])
                      @consumer = Consumer.find_by(id: params[:id])
                      @library = Library.find_by(id: @consumer.library_id)
    #binding.pry
                      erb :'/consumers/edit'
                  else
                      redirect "/consumers/#{params[:id]}"
                  end
            end
            patch '/consumers/:id' do

                  @consumer = Consumer.find_by(id: params[:id])
                  @consumer.update(params[:consumer])
#                  @consumer.save

                  flash[:message] = "Successfully updated consumer profile."
                  redirect("/consumers/#{@consumer.id}")
            end
            get '/consumers/:id/delete' do
  #      binding.pry
                    if consumer_logged_in? && params[:id].to_i == session[:consumer_id]
                      @consumer = Consumer.find_by(id: params[:id])
                      erb :"/consumers/delete"
                    elsif librarian_logged_in?
                      @consumer = Consumer.find_by(id: params[:id])
                      erb :"/consumers/delete"
                    else
                        redirect '/'
                    end

            end

            delete '/consumers/:id' do
    #    binding.pry
    #below allows a librarian to delete a consumer account, but not be logged out themself during the proccess
              if librarian_logged_in?
                @consumer = Consumer.delete(params[:id])
                redirect "/"
              end
              @consumer = Consumer.delete(params[:id])
              session.clear
              redirect "/"
            end
end


#
