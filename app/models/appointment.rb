class Appointment < ActiveRecord::Base
	validates :first_name, :last_name, :start_time, :end_time, presence: true

	before_save :is_valid_days, :is_future_appointment, :can_it_be_booked
	before_create :is_valid_days, :is_future_appointment, :can_it_be_booked
	before_update :is_valid_days, :is_future_appointment, :can_it_be_booked

	private

	def is_valid_days
		if self.start_time >= self.end_time
			errors.add(:end_time, "Appointment ends before it starts")
			return false
		end
	end

	def is_future_appointment
		time = Time.now
		if self.start_time < time
			errors.add(:start_time, "Appointment must be in the future")
			return false
		end
	end

	def can_it_be_booked
		bod = self.start_time.beginning_of_day
		eod = self.end_time.end_of_day
		today_appts = Appointment.where(:start_time => bod...eod)
		if today_appts.count > 0
			today_appts.each do |appt|
				if self.start_time < appt.end_time && self.end_time > appt.start_time
					errors.add(:start_time, "Appointment is overlapping")
					return false
				end
			end
		end
		true
	end

end
