class ProfileController < ApplicationController
  before_filter :login_required 
  
  # This show action only allows users to view their own profile
  def show
    @user = current_user
  end  

  def edit
    @user = current_user
  end

  def update
    # handle cancel button - user friendly form!!!
    if params[:commit] == 'Cancel'
      redirect_to :action => :show
    else
      @user = current_user
      if @user.update_attributes(params[:user])
#      if @user.update_attributes(:name  => params[:user][:name],
#                                :email => params[:user][:email],
#                                :time_zone => params[:user][:time_zone],
#                                :language => params[:user][:language] )
        flash[:notice] = "Profile updated."
        log_action("Security", "User (#{current_user.login}) has changed their profile: #{@user.name}, #{@user.email}, #{@user.time_zone}")
        redirect_to :action => 'show'
      else
        flash.now[:error] = "There was a problem updating your profile."
        log_action("Security", "User (#{current_user.login}) has FAILED to update their profile")
        render :action => 'edit'
      end
    end
  end

end
