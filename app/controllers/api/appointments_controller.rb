class Api::AppointmentsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		appointments = Appointment.all
		render_json_success_with_appointment(appointments)
	end

	def show
		if params[:id] == "q"
			appointment = Appointment.where(:start_time => params[:start_time]..params[:end_time])
		else
			appointment = Appointment.find(params[:id])
		end
		render_json_success_with_appointment(appointment)
	end

	def update
		appointment = Appointment.find(params[:id])
		if Time.now < appointment.start_time
			if appointment.update(appointment_params)
				appointment.save
				render_json_success_with_appointment(appointment)
			else
				render_json_error(appointment.errors)
			end
		else
			render_json_error("You can only make changes to future appointments")
		end
	end

	def create
		appointment = Appointment.new(appointment_params)
		appointment.end_time = appointment.start_time + 5.minutes
		bod = appointment.start_time.beginning_of_day
		eod = appointment.end_time.end_of_day
		today_appts = Appointment.where(:start_time =>  bod...eod)
		if today_appts.count > 0
			conflict = get_resolution(today_appts, appointment.start_time, appointment.end_time)
		else
			conflict = false
		end
		unless conflict
			if appointment.save
				render_json_success_with_appointment(appointment)
			else
				render_json_error(appointment.errors)
			end
		else
			render_json_error("New appointment conflicts with existing appointment. New appointment cannot be saved.")
		end
	end

	def destroy
		appointment = Appointment.find(params[:id])
		appointment.destroy
		render_json_success
	end

	private 

	def get_resolution(collection, start_t, end_t)
		problem_one = 0
		problem_two = 0
		collection.each do |appt|
			problem_one = check_start_conflict(appt.start_time, appt.end_time, start_t)
			puts "**************"
			puts "problem_one = #{problem_one}"
			problem_two = check_end_conflict(appt.start_time, appt.end_time, end_t)
			puts "problem_two = #{problem_two}"
			puts "**************"
			break if (problem_one || problem_two)
		end
		(problem_one || problem_two)
	end

	def check_start_conflict(arg1, arg2, time)
		time >= arg1 && time < arg2 ? true : false
	end

	def check_end_conflict(arg1, arg2, time)
		time > arg1 && time < arg2 ? true : false
	end

	def appointment_params
		params.require(:appointment).permit(:first_name, :last_name, :start_time, :end_time, :comments)
	end

	def render_json_error(error_msg)
		render status: 422, json: {
			status: 422,
			errors: error_msg
		}.to_json		
	end

	def render_json_success
		render status: 200, json: {
			status:200,
		}.to_json
	end

	def render_json_success_with_appointment(appointment)
		render status: 200, json: {
			status: 200,
			appointment: appointment
		}.to_json
	end


end