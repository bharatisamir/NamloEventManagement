class EmailController < ApplicationController
  layout 'reservation'
  def index
    @email = Email.new
  end

  def new
    @email = Email.new

=begin
    if controller_name == 'events'
      render 'email/create'

    end
=end


  end

  def create

    @email = Email.new(params.require(:email).permit(:name, :email, :subject, :message))
    @email.request = request

    if @email.valid?
      NamloMailer.general_email(@email, current_user).deliver
      if ($message == 200)
        flash.now[:notice] = 'Your email has been sent!'

      else
        flash.now[:error] = 'Cannot send message.'
        render :new
      end
    else
      render :new
    end

  end
end
