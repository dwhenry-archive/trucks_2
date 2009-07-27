class Load < ActiveRecord::Base
  include Geokit::Geocoders
  
  belongs_to :company

  validates_presence_of     :load_type, :start_loc, :start_lat, :start_lng
  validates_presence_of     :end_loc, :end_lat, :end_lng, :load_date
  #validates_uniqueness_of   :name, :abn

  validate           :check_position_stats

  def load_date_str
    return self.load_date.strftime("%d %b %Y") unless load_date.blank?
    return Date.today.strftime("%d %b %Y") 
  end
  def load_date_str=(val)
    self.load_date = val
  end

protected
  def check_position_stats
    errors.add('start_loc','Missing GeoCode') if self.start_lat.blank? or self.start_lng.blank?
    errors.add('end_loc','Missing GeoCode') if self.end_lat.blank? or self.end_lng.blank?
    
    return if self.start_loc.blank? or self.end_loc.blank? or 
        self.start_lat.blank? or self.start_lng.blank? or
        self.end_lat.blank? or self.end_lng.blank? or

    start_loc = MultiGeocoder.geocode(self.start_loc)
    end_loc = MultiGeocoder.geocode(self.end_loc)
    self.distance = end_loc.distance_from(start_loc)
    if self.distance < 50
      # all below errors are required to ensure fault output correctly on create..
      errors.add('Distance','From and To Point must be greater than 50km apart') 
      errors.add('start_loc','From and To Point must be greater than 50km apart')
      errors.add('end_loc','From and To Point must be greater than 50km apart') 
    end
  end
end
