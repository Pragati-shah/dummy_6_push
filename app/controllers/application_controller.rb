class ApplicationController < ActionController::Base
	def after_sign_in_path_for(resource)
  		stored_location_for(resource) || employee_index_path
	end

	def after_sign_out_path_for(resource)
  		root_path
	end
end
