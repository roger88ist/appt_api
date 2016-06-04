class Appointment < ActiveRecord::Base
	validates :first_name, :last_name, :start_time, :end_time, presence: true

	before_create :is_valid_days, :is_future_appointment 

	protected

	def is_valid_days
		self.start_time < self.end_time ? true :false
	end

	def is_future_appointment
		time = Time.now
		self.start_time > time && self.end_time > time ? true : false
	end

end
