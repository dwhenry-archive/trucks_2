class CreateMapPoints < ActiveRecord::Migration
  def self.up
    create_table :map_points do |t|
      t.references :load
      t.string :point_type
      t.string :load_type
      t.float :lat
      t.float :lng
      t.float :point_dist

      t.timestamps
    end

    add_index :map_points, [:load_type, :point_type]
  end

  def self.down
    drop_table :map_points
  end
end
