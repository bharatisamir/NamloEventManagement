class NamloMailer < ApplicationMailer
  default from: 'namloeventmanagement@gmail.com'
  #default from: 'namloevent@gmail.com'

=begin
  def password_reset(user)
    @user = user

    mail(to: @user.first_name, subject: 'password reset instructions')
  end
=end


=begin
  def mail_test(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: 'bharatisamir@gmail.com', subject: 'Welcome to My Awesome Site')
  end
=end



=begin
  def welcome_email(user)

    @url  = 'http://example.com/login'
    mail(to: user, subject: 'Welcome to NamloEventManagement Site', text:"test")
  end
=end

=begin
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: 'bharatisamir@gmail.com', subject: 'Welcome to NamloEventManagement Site', text:"test")
  end
=end

=begin
  def mail_test(user)
    @user = user
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      #:to      => @user.email,
                      :to      => 'bharatisamir@gmail.com',
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message ENV['domain'], message_params
  end
=end

=begin
  def mail_test(user)
    #@user = user

    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => user,
                      #:to      => @user.email,
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message ENV['domain'],message_params
    # mg_client.send_message ENV['domain'], message_params
  end
=end



=begin
  def mail_test(user)
    @user = user

    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => 'bharatisamir@gmail.com',
                      #:to      => @user.email,
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message ENV['domain'],message_params
   # mg_client.send_message ENV['domain'], message_params
  end
=end

=begin
  def sample_email(user)
    @user = user

    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      #:to      => 'bharati_sameer@hotmail.com',
                      :to      => @user.email,
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message ENV['domain'], message_params


  end
=end

=begin
  def registration_confirmation(user)
    @user = user

    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => %("#{@user.name}" <#{@user.email}>),
                      :subject => 'Registration Confirmation',
                      #:text    => @contact.message
    }
    mg_client.send_message ENV['domain'], message_params

  end
=end

=begin
  def contact_us(contact)
    @contact = contact

    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => %("#{@contact.name}" <#{@contact.email}>),
                      :to      => ENV['gmail_username'],
                      :subject => @contact.subject,
                      :text    => @contact.message}
    $message = mg_client.send_message ENV['domain'], message_params

  end
=end

=begin
  def account_activation(user)
    @user = user

    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => %("#{@user.name}" <#{@user.email}>),
                      :subject => 'Account Activation',
                      #:text    => @contact.message
                      :text    =>  %("Welcome #{@user.name}, \n Please click this link to activate your Account. \n
    <%= link_to "Activate my account", edit_account_activation_url(@user.activation_token, email: @user.email) %>
    </p>" )


    }
    mg_client.send_message ENV['domain'], message_params

  end
=end

=begin
  def password_reset(user)
    @user = user

    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => %("#{@user.name}" <#{@user.email}>),
                      :subject => 'Account Activation',
                      #:text    => @contact.message
                      :text    =>  %("Welcome #{@user.name}, \n Please click this link to reset your password. \n
    <%= link_to "Reset Password", edit_account_activation_url(@user.activation_token, email: @user.email) %>
    </p>" )


    }
    mg_client.send_message ENV['domain'], message_params

  end
=end

  def contact_us(contact)
    @contact = contact

    mail(from: %("#{@contact.name}" <#{@contact.email}>),to: 'namloeventmanagement@gmail.com', subject: @contact.subject)
    $message = 200
  end

  def invitation_email(event,user)
    @user = user
    @event = event
    @recipients = GuestList.where(('event_id LIKE ?'),@event.id )
    @event_invitation = Invitation.find_by_event_id(@event.id )

    if ((@event!= nil) || (@recipients!= nil) || (@event_invitation!= nil))

      mail(
          from: %("#{@user.first_name}" <#{@user.email}>),
          bcc: @recipients.map(&:email).uniq,
          subject: 'Event Invitation')
      $message = 200

    end



  end

  def general_email(email,user)
    @user = user
    @email = email
    mail(
        from: %("#{@user.first_name}" <#{@user.email}>),
        to: %("#{@email.name}" <#{@email.email}>),
        subject: @email.subject,
        body: @email.message
    )
    $message = 200

  end

end
