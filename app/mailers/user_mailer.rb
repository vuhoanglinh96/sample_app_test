class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    @greeting = t ".greeting"

    mail to: user.email, subject: t(".subject")
  end
end
