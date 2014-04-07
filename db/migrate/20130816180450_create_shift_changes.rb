class CreateShiftChanges < ActiveRecord::Migration
  def change
    create_table :shift_changes do |t|
      t.date :change_date

      t.timestamps
    end
  end
end
