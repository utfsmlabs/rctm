ActiveAdmin.register Shift do
	index do
	  column :name do |shift|
	    shift.name
	  end
	  default_actions
	end
end
