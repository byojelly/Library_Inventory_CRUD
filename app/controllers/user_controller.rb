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
                                          erb :'/librarians/onboarding' #ok to keep in views distinguish user profiles
                                  elsif !is_number?(params[:user][:age])
                                          flash[:message] = "Please make sure that your age is numerical."
                                          erb :'/librarians/onboarding'

                                  elsif !is_number?(params[:user][:start_year])
                                                  flash[:message] = "Please make sure that your first year worked input is numerical."
                                                  erb :'/librarians/onboarding'
                                  else
                                    @user.update(params[:user])
                                    @library = Library.find_by(id: @user.library_id)
                                    @library.users << @user
                                    @user.save
                #binding.pry
                                    redirect "/librarians/#{@librarian.id}"
                                    #keep this route to librarians but nest in user controller
                                  end

                            else
                                    flash[:message] = "Please try again. You must select a local library during the onboarding."
                                      erb :'/librarians/onboarding'
                            end
            elsif consumer_logged_in?
binding.pry
            end
    end
end
