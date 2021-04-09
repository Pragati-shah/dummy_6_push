class EmployeeController < ApplicationController
 # include ApplicationHelper	
  def index
  	#@logged_in_user = session[:logged_in_user]
  	#puts "email ================"+@logged_in_user.inspect
  	#@logged_in_user1 = User.find(session[:logged_in_user]['id'])
    @month_attendances = current_user.attendances.where(["month(attendace_date) = #{Date.today.month}"])
    @temperature = Attendance.all.where(['temperature is not null'])
    
  end
  def attendance
  	#@logged_in_user1 = current_user
  	@today_attendance = current_user.attendances.where("date(created_at) = '#{Date.today}'")
  	if(@today_attendance == [])
	  @attendance_submitted = current_user.attendances.new
	  #@attendance_submitted.user_id = @logged_in_user['id']
	  @attendance_submitted.attendace_date = Date.today
	  @attendance_submitted.present_for_day = true
	  @attendance_submitted.save
	elsif(@today_attendance != [])
	  @attendance_submitted = @today_attendance.first
	  #@attendance_submitted.user_id = @logged_in_user['id']
	  @attendance_submitted.attendace_date = Date.today
	  @attendance_submitted.present_for_day = true
	  @attendance_submitted.save

	end			
  	redirect_to employee_index_path
  end	
  def temperature
  	@today_temperature=current_user.attendances.where("date(created_at) = '#{Date.today}'")
  	if(@today_temperature != [])
  		@today_temperature.first.temperature_time = Time.now
  		@today_temperature.first.temperature = params[:temperature].to_f
  		@today_temperature.first.save
  	elsif(@today_temperature == [])
  		@today_temperature1 = current_user.attendances.new
  		@today_temperature1.temperature_time = Time.now
  		@today_temperature1.temperature=params[:temperature].to_f
  		@today_temperature1.save
  	end	
  	redirect_to employee_index_path
  end	
end