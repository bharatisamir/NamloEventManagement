class Email < MailForm::Base

  #--------------------- FORM VALIDATIONS -------------------------

  attribute :name
  attribute :email
  attribute :subject
  attribute :message
  attribute :nickname,  :captcha  => true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: 255}
  validates :email, presence: true, length: {maximum: 255},format: {with: VALID_EMAIL_REGEX }
  validates :subject, presence: true, length: {maximum: 255}
  validates :message, presence: true, length: {maximum: 2000}

  #--------------------- End of VALIDATIONS -------------------------


  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => '#{subject}',
        :to => %("#{name}" <#{email}>),
        :from => ENV['gmail_username']
    }
  end
end
