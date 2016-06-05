class Api::AppointmentsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		appointments = Appointment.all
		render_json_success_with_appointment(appointments)
	end

	def show
		case params[:id]
		when "q"
			if params[:first_name]
				appointment = Appointment.where('lower(first_name) = ?', params[:first_name].downcase)
			elsif params[:last_name]
				appointment = Appointment.where('lower(last_name) = ?', params[:last_name].downcase)	
			else
				appointment = Appointment.where(:start_time => Time.parse(params[:start_time])..Time.parse(params[:end_time]))
			end
		else
			appointment = Appointment.find(params[:id])
		end
		render_json_success_with_appointment(appointment)
		# if params[:id] == "q"
		# 	appointment = Appointment.where(:start_time => Time.parse(params[:start_time])..Time.parse(params[:end_time]))
		# elsif params[:first_name]
		# 	appointment = Appointment.where('lower(first_name = ?', params[:first_name].downcase)
		# elsif params[:last_name]
		# 	appointment = Appointment.where('lower(last_name = ?', params[:last_name].downcase)		
		# else
		# 	appointment = Appointment.find(params[:id])
		# end
		# render_json_success_with_appointment(appointment)
	end

	def update
		appointment = Appointment.find(params[:id])
		t = Time.now
		if t < appointment.start_time && t < appointment.end_time
			if appointment.update(appointment_params)
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
		if appointment.save
			render_json_success_with_appointment(appointment)
		else
			render_json_error(appointment.errors)
		end
	end

	def destroy
		appointment = Appointment.find(params[:id])
		appointment.destroy
		render_json_success
	end

	private 

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