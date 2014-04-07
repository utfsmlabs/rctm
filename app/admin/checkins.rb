ActiveAdmin.register Checkin do
  	index do
	  selectable_column
          column :name do |checkin|
	    checkin.shift.name
	  end
	  column :period
          column :employee
	  default_actions
	end
end
