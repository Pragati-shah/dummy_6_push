class WelcomeController < ApplicationController
	def index
		
		if Time.now.hour == 11
			#puts Time.now.hour.to_s
			ActionCable.server.broadcast('notification_channel', 'You have visited the welcome page.')

		end
	end 		
end
