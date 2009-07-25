class DashboardController < ApplicationController
  skip_before_filter :login_required #, :only => :home

  def home
  end

end
