class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  #include AuthenticatedSystem
  skip_before_filter :login_required, :only => [:activate,:send_activation_code,:create]

  # render new.rhtml
  def new
    #redirect_to new_company_path
    # @user = User.new
  end
 
  #def create
  #  redirect_to new_company_path
  #  #logout_keeping_session!
  #  #@user = User.new(params[:user])
  #  #success = @user && @user.save
  #  #if success && @user.errors.empty?
  #  #  redirect_back_or_default('/')
  #  #  flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
  #  #else
  #  #  flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
  #  #  render :action => 'new'
  #  #end
  #end

  def activate
    logout_keeping_session!
    @user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    if (!params[:activation_code].blank?) && @user && !@user.active?
      # show password set page...
      flash[:notice] = "Please set User Password to complete Signup!"
      render :action => :new
    else
      # ask for login and resend new activation code
      flash[:notice] = "Incorrect Activation Code!"
      render send_activation_code_path
    end
  end

  def send_activation_code
    if params[:login]
      user = User.find_by_login(params[:login])
      if user
        if Rails.env == "production"
          email = TrucksEmail.deliver_registration_confirmation(user)
        else
          email = TrucksEmail.create_registration_confirmation(user)
          @emails.merge!({user.login => email})
        end
      else
        flash[:notice] = 'Unknown User Login.'
      end
    end
  end

  # Reset password - admin action
  def create
    user = User.find(params[:id])

    if user.activate!(params[:activation_code],params[:password], params[:password_confirmation])
      flash[:notice] = "Password successfully updated."
      #log_action("Security", "User (#{current_user.login}) has reset password for (#{@user.login})")
      # make sure user is logged in
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')

      #redirect_to users_path
    else
      #@old_password = nil
      flash.now[:error] = user.errors.on_base || "There was a problem updating your password."
      #log_action("Security", "Admin (#{current_user.login}) has FAILED to reset password for (#{@user.login})")
      if user and user.activation_code == params[:activation_code]
        render :action => :new
      else
        render :action => 'send_activation_code'
      end
    end
  end
end

