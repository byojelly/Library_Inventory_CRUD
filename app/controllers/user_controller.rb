require './config/environment'
require 'rack-flash'
class UserController < ApplicationController

    use Rack::Flash
    get '/librarians' do
        if !logged_in?
              redirect "/login"
        else
        #          binding.pry
                  if librarian_logged_in?
                      @librarians = librarians_array
                      @librarian = User.find_by(id: session[:user_id])
#binding.pry
                      erb :"/users/librarians/show_all"
                  elsif consumer_logged_in?
                      redirect "/consumers/#{current_user}"
                  end
        end
    end
    get '/consumers' do
#binding.pry
        if !logged_in?
            redirect "/login"
        else
              if librarian_logged_in?
                  @consumers = consumers_array
                  @librarian = User.find_by(id: session[:user_id])
                  erb :"/users/consumers/show_all"
                elsif consumer_logged_in?
                    redirect "/consumers/#{current_user.id}"
                end
        end
    end
    get '/consumers/:id/edit' do
binding.pry
          if consumer_logged_in?
              @consumer = User.find_by(id: params[:id])
              if session[:user_id] == @consumer.id
                  @library = Library.find_by(id: @consumer.library_id)
#binding.pry
                  erb :'/users/consumers/edit'

              else
                #consumers can only view their own edit page
                  redirect "/consumers/#{session[:user_id]}"
              end
          elsif librarian_logged_in?
              @librarian = User.find_by(id: session[:user_id])
              @consumer = User.find_by(id: params[:id])
              @library = Library.find_by(id: @consumer.library_id)
#binding.pry
              erb :'/users/consumers/edit'
          else
              redirect "/consumers/#{params[:id]}"
          end
    end
    post '/users/onboarding' do
          @user = User.find_by(id: session[:user_id])

    #in posts you should not render to a page but you should redirect
    #however i am making an exception to onboarding because i do not want there to be an onboarding route, if a user has an issue during the onboaridng process they still have the ability to log into their account and edit their profile with the proper information
            if librarian_logged_in?
                              @user_librarian = @user
                              if params[:user].has_key?("library_id")
                                        if params[:user][:name]=="" || params[:user][:age]=="" || params[:user][:start_year]==""
                                                flash[:message] = "Please do not leave name/age/first year empty during onboarding."
                                                erb :'/users/librarians/onboarding' #ok to keep in views distinguish user profiles
                                        elsif !is_number?(params[:user][:age])
                                                flash[:message] = "Please make sure that your age is numerical."
                                                erb :'/users/librarians/onboarding'

                                        elsif !is_number?(params[:user][:start_year])
                                                        flash[:message] = "Please make sure that your first year worked input is numerical."
                                                        erb :'/users/librarians/onboarding'
                                        else
                                                  @user.update(params[:user])
                                                  @library = Library.find_by(id: @user.library_id)
                                                  @library.users << @user
                                                  @user.save
                              #binding.pry
                                                  redirect "/librarians/#{@user.id}"
                                                  #keep this route to librarians but nest in user controller
                                        end

                            else
                                        flash[:message] = "Please try again. You must select a local library during the onboarding."
                                          erb :'/users/librarians/onboarding'
                            end
            elsif consumer_logged_in?
#binding.pry
                              @user_consumer = @user
##binding.pry#
                              if params[:user].has_key?("library_id")
                                    if params[:user][:name]=="" || params[:user][:age]=="" || params[:user][:address]==""
                                            flash[:message] = "Please do not leave name/age/address empty during onboarding."
                                            erb :'/users/consumers/onboarding'
                                    elsif !is_number?(params[:user][:age])  #helper method
                                            flash[:message] = "Please make sure that your age input is numerical."
                                            erb :'/users/consumers/onboarding'
                                    else
                                      @user.update(params[:user])
                                      @library = Library.find_by(id: @user.library_id)
                                      @library.users << @user
                                      @user.save
                  #binding.pry
                                      redirect "/consumers/#{@user.id}"
                                    end
                              else
                              flash[:message] = "Please try again. You must select a local library during the onboarding."
                                erb :'/users/consumers/onboarding'
                              end

            end
    end
    get '/librarians/:id' do
#binding.pry
#librarians can view other librarian pages not edit
              if librarian_logged_in?
                    @librarian = User.find_by(id: params[:id]) #browser input
                    #if session[:user_id] == @librarian.id      #does logged n user match the profile they want  to look at?
                      @library = Library.find_by(id: @librarian.library_id)
#  binding.pry
                      erb :'/users/librarians/show'
              else
                    redirect "/login"
                    flash[:message] = "Librarians may only view a librarian profile."
              end

    end
    get '/consumers/:id' do
#binding.pry

#librarians can view all consumer account info
#consumers cannot see an account unless they are logged in
#consumers cannot see account info unless it is their own via session
              if librarian_logged_in? #helper
                            @consumer = User.find_by(id: params[:id])
                            @library = Library.find_by(id: @consumer.library_id)
                            erb :'/users/consumers/show'
              elsif consumer_logged_in? #helper
                    @consumer = User.find_by(id: params[:id]) #browser input
                    if session[:user_id] == @consumer.id      #does logged in user match the profile they want  to look at?
                            @library = Library.find_by(id: @consumer.library_id)
                            erb :'/users/consumers/show'
                    else
                        redirect "/consumers/#{current_user}" #use helper method
                    end
              else
                    redirect "/login"
              end
    end
    get '/librarians/:id/edit' do
#binding.pry
                        if librarian_logged_in?
                            @librarian = User.find_by(id: params[:id])
                                if session[:user_id] == @librarian.id
                                    @library = Library.find_by(id: @librarian.library_id)
#binding.pry
                                    erb :'/users/librarians/edit'
                                else

                                redirect "/librarians/#{params[:id]}" #librarians cant edit other librarian pages
                                end

                        elsif consumer_logged_in? # consumers
                            redirect "/consumers/#{current_user}"
                        else
                              redirect "/"
                        end
    end
    #patch for all users (consumers and librarians)
    patch '/users/:id' do
#binding.pry
          @user = User.find_by(id: params[:id])
          if librarian_logged_in?
                #accessing a consumer or librarian
                  #librarian

                        if User.find(params[:id]).librarian == true
                                                  #binding.pry
                                      if params[:user][:name]=="" || params[:user][:username]=="" || params[:user][:age]=="" || params[:user][:start_year]=="" || params[:user][:address]==""  || params[:user][:email]==""
                                              flash[:message] = "Please do not leave the input sections empty when submiting an edit."
                                              redirect "/librarians/#{session[:user_id]}/edit"
                                      elsif !is_number?(params[:user][:age]) || !is_number?(params[:user][:start_year])
                                              flash[:message] = "Please make sure that your age and first year of employment is numerical."
                                              redirect "/librarians/#{session[:user_id]}/edit"
                                      elsif !params[:user].has_key?("library_id")
                                            flash[:message] = "Please make sure that you select a library."
                                            redirect "/librarians/#{session[:user_id]}/edit"
                                      else
                                                @user.update(params[:user])
                                                            #above method can be written  with a neater hash nested under a consumer key in the patch form

                                                flash[:message] = "Successfully updated consumer profile."
                                                redirect("/librarians/#{@user.id}")
                                      end
                        #accessing consumer (important to distinguish because consumer does not have start yr)
                        elsif User.find(params[:id]).librarian == false

                  #binding.pry
                                      if params[:user][:name]=="" || params[:user][:age]=="" || params[:user][:username]==""  || params[:user][:address]==""  || params[:user][:email]==""
                                              flash[:message] = "Please do not leave the input sections empty when submiting an edit."
                                              redirect "/consumers/#{@user.id}/edit"
                                      elsif !is_number?(params[:user][:age])
                                              flash[:message] = "Please make sure that your age and first year of employment is numerical."
                                              redirect "/consumers/#{@user.id}/edit"
                                      elsif !params[:user].has_key?("library_id")
                                            flash[:message] = "Please make sure that you select a library."
                                            redirect "/consumers/#{@user.id}/edit"
                                      else
                                                @user.update(params[:user])
                                                            #above method can be written  with a neater hash nested under a consumer key in the patch form

                                                flash[:message] = "Successfully updated consumer profile."
                                                redirect "/consumers/#{@user.id}"
                                      end
                        end
          elsif consumer_logged_in?
#binding.pry

                        if User.find(params[:id]).librarian == true #if accessing librarian
                                    redirect "/consumers/#{current_user}"
                        else #if accessing consumer
                              if current_user.id == params[:id].to_i
                                  @user.update(params[:user])
                                  flash[:message] = "Successfully updated consumer profile."
                                  redirect("/consumers/#{current_user.id}")
                              else #editing someone elses consumer
                                  redirect("/consumers/#{current_user.id}")
                              end

                        end
          end
    end
    get '/librarians/:id/delete' do
#    binding.pry
      if librarian_logged_in?
              @librarian = User.find_by(id: params[:id])
              erb :"/users/librarians/delete"
      else
          redirect "/librarians"
      end

    end
#single delete action of all users
    delete '/users/:id' do
binding.pry

          if librarian_logged_in?
                if current_user == User.find(params[:id]) #if deleting logged in users own account
                      User.delete(params[:id])
                      session.clear
                      redirect "/"
                else
                      User.delete(params[:id])
                      redirect "/librarians"
                end
          elsif consumer_logged_in?
              if current_user == User.find(params[:id]) #consumers can delete their on profile but not others
                      User.delete(params[:id])
                      session.clear
                      redirect "/"
              else
                      redirect "/"
              end
          end
    end
end
