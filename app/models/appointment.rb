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

	# def get_resolution
	# 	problem_one = 0
	# 	problem_two = 0
	# 	bod = self.start_time.beginning_of_day
	# 	eod = self.end_time.end_of_day
	# 	today_appts = Appointment.where(:start_time => bod...eod)
	# 	today_appts.each do |appt|
	# 		problem_one = check_start_conflict(appt.start_time, appt.end_time, self.start_time)
	# 		problem_two = check_end_conflict(appt.start_time, appt.end_time, self.end_time)
	# 		break if (problem_one || problem_two)
	# 	end
	# end

	# def check_start_conflict

	# end

	# def check_end_conflict

	# end

end
