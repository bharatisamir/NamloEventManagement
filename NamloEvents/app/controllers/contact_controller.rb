class ContactController < ApplicationController

  def index
    @contact = Contact.new
  end

  def new
    @contact = Contact.new
  end


  def create
    #@contact = Contact.new(params[:contact])
    @contact = Contact.new(params.require(:contact).permit(:name, :email, :subject, :message))
    @contact.request = request

    if @contact.valid?
      NamloMailer.contact_us(@contact).deliver
      if ($message == 200)
        flash.now[:notice] = 'Thank you for your message. We will contact you soon!'

      else
        flash.now[:error] = 'Cannot send message.'
        render :new
      end
    else
      render :new
    end

    #SendEmailJob.send(wait: 30.seconds).perform_later(@contact)


  end
end
