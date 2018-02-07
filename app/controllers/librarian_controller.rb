require './config/environment'
require 'rack-flash'
class LibrarianController < ApplicationController

    use Rack::Flash
            get '/librarians' do
    #          binding.pry
              if librarian_logged_in?
                  @librarians = Librarian.all
                  @librarian = Librarian.find_by(id: session[:librarian_id])
                  erb :"/librarians/show_all"
              elsif consumer_logged_in?
                  redirect "/consumers/#{@consumer.id}"
              else
                  redirect "/login"
              end
            end
#            post '/librarians/onboarding' do
#                  @librarian = Librarian.find_by(id: session[:librarian_id])
##binding.pry
##because this is a post request we dont want to render to a different page (ioe erb "librarians/onboarding")
##what we ant to do is redirect to where we want to go
#                    if params.has_key?("library_id")
#                          if params[:librarian][:name]=="" || params[:librarian][:age]=="" || params[:librarian][:start_year]==""
#                                  flash[:message] = "Please do not leave name/age/first year empty during onboarding."
#                                  erb :'/librarians/onboarding'
#                          elsif !is_number?(params[:librarian][:age])
#                                  flash[:message] = "Please make sure that your age is numerical."
#                                  erb :'/librarians/onboarding'
#
#                          elsif !is_number?(params[:librarian][:start_year])
#                                          flash[:message] = "Please make sure that your first year worked input is numerical."
#                                          erb :'/librarians/onboarding'
#                          else
#                            @librarian.update(params[:librarian])
#                            @library = Library.find_by(id: @librarian.library_id)
#                            @library.librarians << @librarian
#                            @librarian.save
#                            redirect "/librarians/#{@librarian.id}"
#                          end
#
#                    else
#                            flash[:message] = "Please try again. You must select a local library during the onboarding."
#                              erb :'/librarians/onboarding'
#                    end
#            end

            get '/librarians/:id' do
#binding.pry
                      if librarian_logged_in?
                            @librarian = Librarian.find_by(id: params[:id]) #browser input
                            if session[:librarian_id] == @librarian.id      #does logged n user match the profile they want  to look at?
                                    @library = Library.find_by(id: @librarian.library_id)
                                    erb :'/librarians/show'
                            else
                                redirect "/librarians/#{session[:librarian_id]}"
                            end
                      else
                            redirect "/login"
                            flash[:message] = "Librarians may only view their own personal profile."
                      end

            end
            get '/librarians/:id/edit' do
            #  binding.pry
                                if librarian_logged_in?
                                    @librarian = Librarian.find_by(id: params[:id])
                                    if session[:librarian_id] == @librarian.id
                                        @library = Library.find_by(id: @librarian.library_id)
              #binding.pry
                                        erb :'/librarians/edit'

                                    else
                                      #if the signed in user does not match the edit page they are trying to get to, they will be redirected to their own show page
                                        redirect "/librarians/#{session[:librarian_id]}"
                                    end
                                else
                                    redirect "/librarians/#{params[:id]}"
                                end
            end
            patch '/librarians/:id' do
#binding.pry
                      @librarian = Librarian.find_by(id: params[:id])
                      if params[:librarian][:name]=="" || params[:librarian][:age]=="" || params[:librarian][:start_year]=="" || params[:librarian][:username]==""  || params[:librarian][:address]==""  || params[:librarian][:email]==""
                              flash[:message] = "Please do not leave the input sections empty when submiting an edit."
                              redirect "/librarians/#{session[:librarian_id]}/edit"
                      elsif !is_number?(params[:librarian][:age]) || !is_number?(params[:librarian][:start_year])
                              flash[:message] = "Please make sure that your age and first year of employment is numerical."
                              redirect "/librarians/#{session[:librarian_id]}/edit"
                      elsif !params[:librarian].has_key?("library_id")
                            flash[:message] = "Please make sure that you select a library."
                            redirect "/librarians/#{session[:librarian_id]}/edit"
                      else
                                @librarian.update(params[:librarian])
                                            #above method can be written  with a neater hash nested under a consumer key in the patch form

                                flash[:message] = "Successfully updated consumer profile."
                                redirect("/librarians/#{@librarian.id}")
                      end

            end
            get '/librarians/:id/delete' do
    #    binding.pry
              @librarian = Librarian.find_by(id: params[:id])
              erb :"/librarians/delete"
            end

            delete '/librarians/:id' do
    #    binding.pry
              @librarian = Librarian.delete(params[:id])
              session.clear
              redirect "/"
            end
end
