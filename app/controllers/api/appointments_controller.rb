class Api::AppointmentsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		appointments = Appointment.all
		render json: { 
			status: 200,
			appointments: appointments
		}.to_json
	end

	def show
		appointment = Appointment.find(params[:id])
		render json: {
			status: 200,
			appointment: appointment
		}.to_json
	end

	def create
		appointment = Appointment.new(appointment_params)
		if appointment.save
			render json: {
				status: 200,
				appointment: appointment
			}.to_json
		else
			render json: {
				status: 500,
				errors: appointment.errors
			}.to_json
		end
	end

	private 

	def appointment_params
		params.require(:appointment).permit(:first_name, :last_name, :start_time,																	 :end_time, :comments)
	end
end