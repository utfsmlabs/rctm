# encoding: utf-8
class Log < ActiveRecord::Base
  attr_accessible :status, :employee, :shift, :day, :time, :period
  has_one :shift_msg
  def after_save()
    Log.absences()
  end

  def status_enum
  	['Absent','Late','Ok']
  end

	def self.absences()
		@Period = Period.where("beginning < '#{Date.today}'").where("end_at > '#{Date.today}'")
		unless @Period.empty?
			@checkins = Checkin.where(:period_id=>@Period)
			unless @checkins.empty?
				diff = Date.today.mjd - @Period.first.beginning.mjd
				if ShiftChange.last.change_date > @Period.first.beginning
					diff = Date.today.mjd - ShiftChange.last.change_date.mjd
				end
				for d in 1..diff
					day = @Period.first.beginning + d.days
					if ShiftChange.last.change_date > @Period.first.beginning
						day = ShiftChange.last.change_date + d.days
					end
					wd = I18n.localize(day, :format => '%A') 
					shifts = Shift.where(:weekday=>wd)
					for s in shifts
						@checks = @checkins.where(:shift_id=>s.id)
						for check in @checks
							@L = Log.where(:employee=>check.employee.name,:shift=>s.name,:day=>day,:period=>Period.actual_period.name)
							if @L.empty? 
								unless day === Date.today
									Log.create(:employee=>check.employee.name,:shift=>s.name,:day=>day,:time=>s.block.end_at,:status=>"Absent",:period=>Period.actual_period.name)
								else
									if TimeOfDay.parse(s.block.end_at) < Time.now.to_time_of_day
										Log.create(:employee=>check.employee.name,:shift=>s.name,:day=>day,:time=>s.block.end_at,:status=>"Absent",:period=>Period.actual_period.name)
									end
								end
							end
						end
					end
				end
			end
		end
	end

	def ammend()
		self.status="Ok"
	end

  def self.search(search)
    if search
      where('employee LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
