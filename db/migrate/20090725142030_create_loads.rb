class CreateLoads < ActiveRecord::Migration
  def self.up
    create_table :loads do |t|
      t.string :load_type
      
      t.string :start_loc
      t.float :start_lat # used to store radian location
      t.float :start_lng # used to store radian location
      t.string :end_loc
      t.float :end_lat # used to store radian location
      t.float :end_lng # used to store radian location
      t.float :distance 

      t.date :load_date

      t.references :company

      t.text :details # serialised representation

      t.boolean :filled, :default => 0
      t.boolean :deleted, :default => 0

      t.timestamps
    end

  end

  def self.down
    drop_table :loads
  end
end
