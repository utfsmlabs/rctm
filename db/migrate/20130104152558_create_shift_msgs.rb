class CreateShiftMsgs < ActiveRecord::Migration
  def change
    create_table :shift_msgs do |t|
      t.string :username
      t.text :message
      t.references :log

      t.timestamps
    end
  end
end
