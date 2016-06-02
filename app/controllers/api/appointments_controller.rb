class Api::AppointmentsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		appointments = Appointment.all
		render json: appointments
	end

	def show
		appointment = Appointment.find(params[:id])
		render json: appointment
	end

	def create
		appointment = Appointment.new(appointment_params)
		if appointment.save
			head 200
		else
			head 500
		end
	end

	private 

	def appointment_params
		params.require(:appointment).permit(:first_name, :last_name, :start_time,																	 :end_time, :comments)
	end
end