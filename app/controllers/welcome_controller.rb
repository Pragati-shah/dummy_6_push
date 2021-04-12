class WelcomeController < ApplicationController
	def index
		
		if Time.now.hour == 18
			#puts Time.now.hour.to_s
			ActionCable.server.broadcast "notifications:#{current_user.id}", {html: "<div>Hello world</div>"}

		end
	end 		
end
