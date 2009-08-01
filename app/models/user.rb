require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessor :pwd
  
  belongs_to :company
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :make_activation_code
  before_validation :make_temp_password

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :password, :password_confirmation


  # Activates the user in the database.
  def activate!(act_code, new_password, new_confirmation)
    errors.add_to_base("Invalid Activation Code.") and
      return false if self.activation_code != act_code or act_code.blank?
    errors.add_to_base("New password does not match the password confirmation.") and
      return false if (new_password != new_confirmation)
    errors.add_to_base("New password cannot be blank.") and
      return false if new_password.blank?
    self.password, self.password_confirmation = new_password, new_confirmation
    if self.save
      @activated = true
      self.activated_at = Time.now.utc
      self.activation_code = nil
      self.save#(false)
    end
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def change_password!(old_password, new_password, new_confirmation)
    errors.add_to_base("New password does not match the password confirmation.") and
      return false if (new_password != new_confirmation)
    errors.add_to_base("New password cannot be blank.") and
      return false if new_password.blank? 
    errors.add_to_base("You password was not changed, your old password is incorrect.") and
      return false unless self.authenticated?(old_password) 
    self.password, self.password_confirmation = new_password, new_confirmation
    save
  end

  def temp_password
    @pwd
  end

  def reset_activation_code
    self.make_activation_code
    self.pwd = random_password
    self.save
  end

  protected

  def make_activation_code
      self.activation_code = self.class.make_token
  end

  def make_temp_password
    return unless crypted_password.blank?
    self.pwd = random_password
    self.password = self.pwd
    self.password_confirmation = self.pwd
    logger.info 'Creating new user: "' + login + '" with password: "' + pwd + '"'
  end

  def random_password(size = 8)
    chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end

end
