# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
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

  #before_filter :login_required #:login_required_local 

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
