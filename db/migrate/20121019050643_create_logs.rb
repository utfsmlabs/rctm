class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :status
      t.string :employee
      t.string :shift
      t.date :day
      t.string :time
      t.string :period

      t.timestamps
    end
  end
end
