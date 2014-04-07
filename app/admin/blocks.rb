ActiveAdmin.register Block do
  	index do
	  column :name 
	  column :start_at
	  column :end_at
	  default_actions
	end
end
