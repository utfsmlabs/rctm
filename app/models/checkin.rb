class Checkin < ActiveRecord::Base
	belongs_to :employee
	belongs_to :shift
	belongs_to :period
  	attr_accessible :employee_id, :shift_id, :period_id

	def status
		if Time.now.to_time_of_day > TimeOfDay.parse(self.shift.block.start_at) + 1800
			"Absent"		
		else
			if Time.now.to_time_of_day > TimeOfDay.parse(self.shift.block.start_at) + 900
				"Late"
			else
				"Ok"
			end
		end
	end
end
