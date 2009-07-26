class DashboardController < ApplicationController
  skip_before_filter :login_required #, :only => :home

  def home
  end

  def login
      render :partial => "/shared/login"
  end
  
  def status
      render :partial => "/shared/user_bar"
  end
end
