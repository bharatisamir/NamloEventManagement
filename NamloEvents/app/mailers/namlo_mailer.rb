class NamloMailer < ApplicationMailer
  default from: 'namloevent@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to NamloEventManagement Site')
  end

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

end
