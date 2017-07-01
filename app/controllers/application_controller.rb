class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  def skroutz_client
    Skroutz::Client.new(Figaro.env.skroutz_id, Figaro.env.skroutz_secret)
  end


    def find(search)

    a = checkInputID(params[:search])

   return a

  end

  


  private
   def checkInputID(searchParams)
    if (searchParams.include?"//www.skroutz.gr/")
      return getSkouId(searchParams)
    elsif (searchParams =~ /\A\d+\z/ ? true : false)
        return searchParams
    else
        return -1
    end
  end

  def getSkouId(link)
    return link[/(?<=\/(c|s)\/)\w+/]
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end


end
