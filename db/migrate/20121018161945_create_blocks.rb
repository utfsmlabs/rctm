class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :name
      t.string :start_at
      t.string :end_at

      t.timestamps
    end
  end
end
