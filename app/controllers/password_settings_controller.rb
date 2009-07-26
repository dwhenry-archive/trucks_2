class PasswordSettingsController < ApplicationController

  before_filter :admin_required, :only => :new 

  # change password
  #def index

  #end
  
  # reset password by admin
  def new
    @user = User.find(params[:profile_id])
  end

  def edit
    
  end

  # Reset password - admin action
  def create
    @user = User.find(params[:id])
    
    if @user.reset_password!(params[:password], params[:password_confirmation])
      flash[:notice] = "Password successfully updated."
      #log_action("Security", "User (#{current_user.login}) has reset password for (#{@user.login})")
      redirect_to users_path    
    else
      #@old_password = nil
      flash.now[:error] = @user.errors.on_base || "There was a problem updating your password."
      #log_action("Security", "Admin (#{current_user.login}) has FAILED to reset password for (#{@user.login})")
      render :action => 'new'
    end
  end
  
  # Change password - individual user action  
  def update
    if current_user.change_password!(params[:old_password], params[:password], params[:password_confirmation])
      flash[:notice] = "Password successfully updated."
      #log_action("Security", "User (#{current_user.login}) has changed their password")
      redirect_to profile_path(current_user)    
    else
      @old_password = nil
      flash.now[:error] = current_user.errors.on_base || "There was a problem updating your password."
      #log_action("Security", "User (#{current_user.login}) has FAILED to change their password")
      render :action => 'edit'
    end
  end
 
end