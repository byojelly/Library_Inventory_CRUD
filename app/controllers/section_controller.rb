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
          if   params[:name]=="" || params[:location]==""
                                  flash[:message] = "Please do not leave the input sections empty when submiting an edit."
                                  redirect "/libraries/#{session[:library_id]}/sections/new"
          elsif  !!Section.find_by(name: params[:name])

                                flash[:message] = "This section name already exists."
                                redirect "/libraries/#{session[:library_id]}/sections/new"
          else

                @section = Section.create(name: params[:name], location: params[:location], library_id: session[:library_id])
                redirect "/libraries/#{session[:library_id]}/sections/#{@section.id}"
          end
    end



end
