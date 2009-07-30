class TrucksEmail < ActionMailer::Base
  def registration_confirmation(user, password, activation_code)
    recipients user.login
    from       "bulkbackloads.com"
    subject    "Welcome to Bulk Back Loads - Activation"
    body       :user => user, :password => password, :activation_code => activation_code
  end

end
