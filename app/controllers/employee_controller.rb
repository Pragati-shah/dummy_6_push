class EmployeeController < ApplicationController
 # include ApplicationHelper	
  def index
  	@logged_in_user = session[:logged_in_user]
  	puts "email ================"+@logged_in_user.inspect
  end
  def attendance
  	@logged_in_user = session[:logged_in_user]
  	@today_attendance = Attendance.where(user_id: @logged_in_user['id'], attendace_date: Date.today)
  	if(@today_attendance == [])
	  
	end  	
  	render employee_index_path
  end	
end