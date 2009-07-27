
class DashboardController < ApplicationController
  include Geokit::Geocoders
  skip_before_filter :login_required #, :only => :home

  def home
  end

  def login
      render :partial => "/shared/login"
  end
  
  def status
      render :partial => "/shared/user_bar"
  end
  
  def geolookup
    return if params[:location].blank?
    
    loc = params[:location]
    loc = loc + ',Australia' unless loc.downcase =~ /(au|aus|aust|australia)$/
    
    location = MultiGeocoder.geocode(loc)
    if location.country_code == 'AU' and !location.accuracy.nil? and location.accuracy > 2
      address = str_replace(location.full_address)

      render :json => { :status => 'success',
          :address => address,
          :lng => location.lng,
          :lat => location.lat}
    else
      render :json => { :status => 'fail' }
    end
  end
  
private
  def str_replace(str)
      res = str
      res = val_replace res, "Australia", "AU" 
      res = val_replace res, "Queensland", "QLD"
      res = val_replace res, "New South Wales", "NSW"
      res = val_replace res, "Victoria", "Vic"
      res = val_replace res, "South Australia", "SA"
      res = val_replace res, "Western Australia", "WA"
      res = val_replace res, "Northern Teritory", "NT"
      res
  end
  
  def val_replace(str, val1, val2)
      str[val1]= val2 unless str.index(val1).nil?
      str
  end
end
