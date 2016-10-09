class ContactController < ApplicationController

  def index
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    NamloMailer.contact_us(@contact).deliver
    #SendEmailJob.send(wait: 30.seconds).perform_later(@contact)

    if ($message.code == 200)
      flash.now[:notice] = 'Thank you for your message. We will contacts you soon!'
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end
end
