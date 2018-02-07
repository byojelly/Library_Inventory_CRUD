require './config/environment'
require 'rack-flash'
class UserController < ApplicationController

    use Rack::Flash
    post '/users/onboarding' do
          @user = User.find_by(id: session[:user_id])
#binding.pry
    #in posts you should not render to a page but you should redirect
    #however i am making an exception to onboarding because i do not want there to be an onboarding route, if a user has an issue during the onboaridng process they still have the ability to log into their account and edit their profile with the proper information
            if librarian_logged_in?
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
binding.pry
            end
    end
    get '/librarians/:id' do
binding.pry
              if librarian_logged_in?
                    @librarian = User.find_by(id: params[:id]) #browser input
                    if session[:user_id] == @librarian.id      #does logged n user match the profile they want  to look at?
                            @library = Library.find_by(id: @librarian.library_id)
                            erb :'/users/librarians/show'
                    else
                        redirect "/librarians/#{session[:user_id]}"
                    end
              else
                    redirect "/login"
                    flash[:message] = "Librarians may only view their own personal profile."
              end

    end

end
