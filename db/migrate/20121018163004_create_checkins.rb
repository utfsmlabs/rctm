class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.references :employee
      t.references :shift
      t.references :period
      t.timestamps
    end
    add_index :checkins, :period_id
  end

  def self.down
    drop_table :checkins
  end
end
