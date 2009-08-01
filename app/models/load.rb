class Load < ActiveRecord::Base
  include Geokit::Geocoders
  
  belongs_to :company
  has_many :map_points

  validates_presence_of     :load_type, :start_loc, :start_lat, :start_lng
  validates_presence_of     :end_loc, :end_lat, :end_lng, :load_date
  #validates_uniqueness_of   :name, :abn
  before_validation    :get_distance
  validate           :check_position_stats

  after_save        :save_map_points

  def load_date_str
    return self.load_date.strftime("%d %b %Y") unless load_date.blank?
    return Date.today.strftime("%d %b %Y") 
  end
  def load_date_str=(val)
    self.load_date = val
  end

protected
  def get_distance
    #debugger
    return if self.start_loc.blank? or self.end_loc.blank? or
        self.start_lat.blank? or self.start_lng.blank? or
        self.end_lat.blank? or self.end_lng.blank?

    start_loc = MultiGeocoder.geocode(self.start_loc)
    end_loc = MultiGeocoder.geocode(self.end_loc)
    self.distance = end_loc.distance_from(start_loc)
  end

  def check_position_stats
    errors.add('start_loc','Missing GeoCode') if self.start_lat.blank? or self.start_lng.blank?
    errors.add('end_loc','Missing GeoCode') if self.end_lat.blank? or self.end_lng.blank?
    
    if self.distance.nil? or self.distance < 50
      # all below errors are required to ensure fault output correctly on create..
      errors.add('Distance','From and To Point must be greater than 50km apart') 
      errors.add('start_loc','From and To Point must be greater than 50km apart')
      errors.add('end_loc','From and To Point must be greater than 50km apart') 
    end
  end

  def save_map_points
    #debugger
    points = self.map_points
    if points.size == 0
      # ya just go and create the required points
      self.map_points.build(:load => self,
        :point_type => 'start',
        :load_type => self.load_type, # added here even though redundent to improve serach performance
        :lat => self.start_lat,
        :lng => self.start_lng,
        :point_dist => self.distance)
      self.map_points.build(:load => self,
        :point_type => 'end',
        :load_type => self.load_type, # added here even though redundent to improve serach performance
        :lat => self.end_lat,
        :lng => self.end_lng,
        :point_dist => self.distance)
      self.save
    elsif points.size == 2
      # darn.. perform and update
      points.each do |point|
        if point.point_type == 'start'
          point.update_attributes(:lat => self.start_lat,
            :lng => self.start_lng,
            :point_dist => self.distance)
        else
          point.update_attributes(:lat => self.end_lat,
            :lng => self.end_lng,
            :point_dist => self.distance)
        end
        point.save
      end
    else
      # should never happen.. but delete and start again
      self.map_points.delete_all
      self.save_map_points
    end

  end
end
