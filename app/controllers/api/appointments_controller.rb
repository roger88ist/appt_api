class Api::AppointmentsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
		appointments = Appointment.all
		render status: 200, json: { 
			status: 200,
			appointments: appointments
		}.to_json
	end

	def show
		appointment = Appointment.find(params[:id])
		render status: 200, json: {
			status: 200,
			appointment: appointment
		}.to_json
	end

	def update
		appointment = Appointment.find(params[:id])
		if appointment.update(appointment_params)
			render status: 200, json: {
				status: 200,
				appointment: appointment
			}.to_json
		else
			render status: 422, json: {
				status: 422,
				errors: appointment.errors
			}
		end
	end

	def create
		appointment = Appointment.new(appointment_params)
		if appointment.save
			render status: 200, json: {
				status: 200,
				appointment: appointment
			}.to_json
		else
			render status: 422, json: {
				status: 422,
				errors: appointment.errors
			}.to_json
		end
	end

	def destroy
		appointment = Appointment.find(params[:id])
		appointment.destroy
		render status: 200, json: {
			status: 200,
		}
	end

	private 

	def appointment_params
		params.require(:appointment).permit(:first_name, :last_name, :start_time,																	 :end_time, :comments)
	end
end