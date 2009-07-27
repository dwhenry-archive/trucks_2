class Company < ActiveRecord::Base
  has_many :users
  has_many :loads,
      :order => 'created_at DESC'
  
#### Validation ####
  
  validates_presence_of     :name, :abn, :address1, :town, :postcode, :pref_type, :phone 
  #:addessline1, :addressline2, :town, :state, :postcode
  validates_uniqueness_of   :name, :abn
  validate                  :validate_fields

#### Field Accessors ####

  def abn=(val)
    # ensure that correct formatting is in place 
    
    write_attribute :abn, (val ? val.downcase : nil)
  end
  
  def new_users=(val)
    errors.add 'Users','require a minimum of 1 user to be created' unless val.size > 0
    self.users = val.map do |user|
      self.users.build(user.merge({:company => self}))
    end
  end
  
private

  def validate_fields
    #if not (email =~ /(.+)@(.+)\.(.{3})/ or email =~ /(.+)@(.+)\.(.{2})/)
    #  errors.add(:email, " Invalid: #{email}" )
    #end
    
    # 11 digit code
    errors.add(:abn, "must be an 11 digit number") if abn and not abn =~ /^(\d{3})[- ]?(\d{4})[- ]?(\d{4})$/

    errors.add(:phone, "must be a 10 digit number") if phone and not phone =~ /^(\(?(\d{2})(\)|-| )?(\d{4})(-| )?(\d{4})|\(?(\d{4})(\)|-| )?(\d{3})[- ]?(\d{3}))$/
    
    errors.add(:postcode, "must be a 4 digit number") if postcode and not postcode =~ /^(\d{4})$/
    
    unless ["truck","contract"].include?(self.pref_type)
      errors.add(:pref_type, "Invalid Selection")
    end
  end

end
