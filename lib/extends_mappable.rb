# this is just a quick and dirty implementation and will most liky have to be changed at some point in the near future
# to handle a larger number of records and be more efficient..
# but until then...
module ExtendsMappable
  include Geokit::Geocoders

  # take a start/end point + journey type and produces sorted array of matching journies
  def self.calcualte_journey(start_point,end_point,load_type)
    dist_a1 = MapPoint.find(:all, :origin => start_point, :conditions => ["point_type = 'start' and load_type != ?",load_type])
    dist_b2 = MapPoint.find(:all, :origin => end_point, :conditions => ["point_type = 'end' and load_type != ?",load_type])
              #debugger
    start_loc = MultiGeocoder.geocode(start_point)
    end_loc = MultiGeocoder.geocode(end_point)
    dist = end_loc.distance_from(start_loc).to_f

    # values to combine
    res = {}
    dist_a1.each do |val|
      res.merge!({val.load_id => {:dist_a1 => val.distance.to_f,
                                 :dist_b2 => 0,
                                 :dist_ab => dist,
                                 :dist_12 => val.point_dist.to_f,
                                 :change => 0}})
    end

    dist_b2.each do |val|
      res[val.load_id][:dist_b2] = val.distance.to_f
      if load_type == 'truck'
        res[val.load_id][:change] = res[val.load_id][:dist_a1] +
                res[val.load_id][:dist_b2] +
                res[val.load_id][:dist_ab] -
                res[val.load_id][:dist_12]
      else
        res[val.load_id][:change] = res[val.load_id][:dist_a1] +
                res[val.load_id][:dist_b2] +
                res[val.load_id][:dist_12] -
                res[val.load_id][:dist_ab]
      end
    end

    # sort by change distance for display purposes..
    res.sort do |a,b|
      a[1][:change] <=> b[1][:change]
    end
  end

end