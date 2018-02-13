require './config/environment'
require 'rack-flash'
class SectionController < ApplicationController

    use Rack::Flash

    get '/sections' do
#binding.pry
       @sections = Section.all
       return "code here later"
    end
    post '/sections/new' do
binding.pry

                @section = Section.create(params[:section])
                @section.library_id = session[:library_id]
                @library = Library.find_by(id: @section.library_id)

                if @section.errors.any?
                      #redirect "/libraries/#{session[:library_id]}/sections/new"
                      #rails validation guidelines say to render, but the url gets messed up
                      #cannot use redirect because the @section.errors gets deleted when redirecting. Only rendering keeps the variable intact
                      erb :"/sections/new" #erb = render
                else
                      redirect "/libraries/#{session[:library_id]}/sections/#{@section.id}"
                end


    end
    patch '/sections/:id' do
#binding.pry
        @section = Section.find_by(id: params[:id])
        if params[:section][:name]=="" || params[:section][:location]==""
              flash[:message] = "Please do not leave input fields empty."
              redirect "/libraries/#{session[:library_id]}/sections/#{@section.id}/edit"
        else
            @section.update(params[:section])
            flash[:message] = "Successfully updated section profile."
            redirect "/libraries/#{session[:library_id]}/sections/#{@section.id}"
        end
    end
    delete '/sections/:id' do
#binding.pry
      @section = Section.delete(params[:id])
      redirect ("/libraries/#{session[:library_id]}")
    end



end
