require './config/environment'
require 'rack-flash'
class SectionController < HelperController

    use Rack::Flash

    get '/sections' do
#binding.pry
       @sections = Section.all
       return "code here later"
    end
    post '/sections/new' do
#binding.pry
          if   params[:section][:name]=="" || params[:section][:location]==""
                                  flash[:message] = "Please do not leave the input sections empty when submiting an edit."
                                  redirect "/libraries/#{session[:library_id]}/sections/new"
          elsif  !!Section.find_by(name: params[:section][:name])

                                flash[:message] = "This section name already exists."
                                redirect "/libraries/#{session[:library_id]}/sections/new"
          else

                @section = Section.create(params[:section])
                @section.library_id = session[:library_id]
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
