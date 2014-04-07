class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.string :weekday
      t.references :block
      t.boolean :meeting, :default=>false

      t.timestamps
    end
    add_index :shifts, :block_id
  end
end
