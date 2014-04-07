ActiveAdmin.register Log do
  index do
  	selectable_column
    column :day
    column :shift
    column :employee
    column :time
    column :status
    default_actions
  end  
    batch_action :Perdonar do |selection|
      Log.find(selection).each do |log|
        log.ammend
        log.save
      end
      redirect_to collection_path, :notice => "Perdonados!"
    end
end
