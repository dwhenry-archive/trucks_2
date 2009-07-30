class TrucksEmail < ActionMailer::Base
  def registration_confirmation(user)
    recipients user.login
    from       "bulkbackloads.com"
    subject    "Welcome to Bulk Back Loads - Activation"
    body       :user => user
  end

end
