class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
  end

  def perform(user)
    @user = user
    NamloMailer.sample_email(@user).deliver_later
  end


  def perform(recipients)
    @recipient = recipients
    NamloMailer.invitation_email(@recipient).deliver_later
  end

end
