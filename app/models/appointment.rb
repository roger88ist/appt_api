class Appointment < ActiveRecord::Base
	validates :first_name, :last_name, :start_time, :end_time, presence: true

	before_save :is_valid_days, :is_future_appointment, :can_it_be_booked
	before_create :is_valid_days, :is_future_appointment, :can_it_be_booked
	before_update :is_valid_days, :is_future_appointment, :can_it_be_booked

	private

	def is_valid_days
		self.start_time < self.end_time ? true : false
	end

	def is_future_appointment
		time = Time.now
		self.start_time > time && self.end_time > time ? true : false
	end

	def can_it_be_booked
		bod = self.start_time.beginning_of_day
		eod = self.end_time.end_of_day
		today_appts = Appointment.where(:start_time => bod...eod)
		if today_appts.count > 0
			today_appts.each do |appt|
				if self.start_time < appt.end_time && self.end_time > appt.start_time
					return false
				end
				# if (self.start_time >= appt.start_time && self.start_time < appt.end_time)
				# 	return false
				# end
				# if (self.end_time > appt.start_time && self.end_time < appt.end_time)
				# 	return false
				# end
			end
		end
		true
	end

end
