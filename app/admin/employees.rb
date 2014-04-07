ActiveAdmin.register Employee do
  index do
    selectable_column
    column :name
    default_actions
  end
end
