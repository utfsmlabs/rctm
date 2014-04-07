class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :name
      t.date :beginning
      t.date :end_at

      t.timestamps
    end
  end
end
