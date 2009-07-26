
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
      render :json => { :status => 'success',
          :address => location.full_address,
          :lng => location.lng,
          :lat => location.lat}
    else
      render :json => { :status => 'fail' }
    end
  end
end
