class CreateLoads < ActiveRecord::Migration
  def self.up
    create_table :loads do |t|
      t.string :load_type
      
      t.string :start_loc
      t.string :start_pos # used to store radian location
      t.string :end_loc
      t.string :end_pos # used to store radian location
      t.date :start_date
      t.date :end_date
      t.integer :am_load, :default => 0
      t.references :company
      t.boolean :filled, :default => 0
      t.boolean :deleted, :default => 0

      t.string :comment

      t.timestamps
    end

  end

  def self.down
    drop_table :loads
  end
end
