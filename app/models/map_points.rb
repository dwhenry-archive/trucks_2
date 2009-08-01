class MapPoints < ActiveRecord::Base
  belongs_to :load

  acts_as_mappable :default_units => :kms,
		:default_formula => :sphere,
		:distance_field_name => :distance,
		:lng_column_name => 'lng',
        :lat_column_name => 'lat'
end
