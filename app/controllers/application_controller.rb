class ApplicationController < ActionController::Base
	def after_sign_in_path_for(resource)#,logged_in_user)
		session[:logged_in_user] = resource
  		stored_location_for(resource) || employee_index_path
	end

	def after_sign_out_path_for(resource)
		session[:logged_in_user] = nil
  		root_path
	end
end
