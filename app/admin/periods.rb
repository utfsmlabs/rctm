ActiveAdmin.register Period do
  	index do
      column :name
	  column :beginning
	  column :end_at
	  default_actions
	end
end
