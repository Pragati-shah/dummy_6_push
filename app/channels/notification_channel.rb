class NotificationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    
    #if(request.params[:email] != "admin@example.com")
    stream_from "notifications_channel"
    #end	
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
