class ApplicationController < ActionController::Base

	include Pundit

	before_action :configure_permitted_parameters, if: :devise_controller?
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
 
	def after_sign_in_path_for(resource)
	  projects_path # your path
	end

	def getdata

    @type = params[:type]
    @data_for_select2=[]

    if @type == "Feature"
    	@data_for_select2 = ["new","started","completed"]
    elsif @type == "Bug"
    	@data_for_select2 = ["new","started","resolved"]	
    end
    	
    # render an array in JSON containing arrays like:
    # [[:id1, :name1], [:id2, :name2]]
    render :json => @data_for_select2
  end
	
	
  	private
 
    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
       redirect_to(request.referrer || root_path)
    end

  	protected	
	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role_id, :name])
  	end
end
