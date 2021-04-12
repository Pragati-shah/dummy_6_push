class EmployeeController < ApplicationController
 # include ApplicationHelper	
  def index
  	#@logged_in_user = session[:logged_in_user]
  	#puts "email ================"+@logged_in_user.inspect
  	#@logged_in_user1 = User.find(session[:logged_in_user]['id'])
  	if (params[:email]!="admin@example.com")
	    @month_attendances = current_user.attendances.where(["month(attendace_date) = #{Date.today.month}"])
	    @temperature = Attendance.all.where(['temperature is not null'])
	    @moderate_temp = Attendance.all.where("temperature <= 36.5 and date(created_at) = '#{Date.today}'").count
	    @warning_temp = Attendance.all.where("temperature <= 36.7 and temperature > 36.5 and date(created_at) = '#{Date.today}'").count
	    @redzone_temp = Attendance.all.where("temperature > 36.7 and date(created_at) = '#{Date.today}'").count
	    #@data = {'Near 36.5': "#{@moderate_temp}", 'Near 36.7': "#{@warning_temp}", 'Near 37.5 and above': "#{@redzone_temp}"}
	  	#@no_of_employee = Attendance.all.where("date(created_at) = '#{Date.today}'").count
	  	#@data = {@moderate_temp,@warning_temp, @redzone_temp}
  	elsif (Time.now.hour == 11 && params[:email]=="admin@example.com" && Time.now.min==0 && Time.now.sec==0)
			#puts Time.now.hour.to_s
			ActionCable.server.broadcast "notifications_channel", {html: "<div>Hello world</div>"}
			render :template => '/home/index'
	elsif(params[:email]=="admin@example.com") 
			render :template => '/home/index'
	end	
	#render layout: 'index'
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