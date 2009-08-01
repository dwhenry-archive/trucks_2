class TrucksEmail < ActionMailer::Base
  def registration_confirmation(user)
    recipients  user.login
    from        "registration@bulkbackloads.com"
    subject     "Bulk Back Loads - Activation"
    body        :user => user
  end

end
