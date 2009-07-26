# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  geocode_ip_address
  layout :determined_by_response
  
protected 
  def determined_by_response
    if request.xhr?
      return false
    else
      'application'
    end
  end

public
  helper :all # include all helpers, all the time
  
  include AuthenticatedSystem
  #include ExceptionLoggable
  
  before_filter :login_required #:login_required_local 

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
protected
  def access_denied
    respond_to do |format|
      format.html do
        store_location
        redirect_to dashboard_home_path
      end
      # format.any doesn't work in rails version < http://dev.rubyonrails.org/changeset/8987
      # Add any other API formats here.  (Some browsers, notably IE6, send Accept: */* and trigger 
      # the 'format.any' block incorrectly. See http://bit.ly/ie6_borken or http://bit.ly/ie6_borken2
      # for a workaround.)
      format.any(:json, :xml) do
        request_http_basic_authentication 'Web Password'
      end
    end
  end  
  
  def admin_required
    # needs to be implemented
  end
end
