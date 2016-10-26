class Contact < MailForm::Base

  #--------------------- FORM VALIDATIONS -------------------------


=begin
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :subject,   :validate => true
  attribute :message,   :validate => true
  attribute :nickname,  :captcha  => true
=end

  attribute :name
  attribute :email
  attribute :subject
  attribute :message
  attribute :nickname,  :captcha  => true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: 255}
  validates :email, presence: true, length: {maximum: 255},format: {with: VALID_EMAIL_REGEX }
  validates :subject, presence: true, length: {maximum: 255}
  validates :message, presence: true, length: {maximum: 255}




  #--------------------- End of VALIDATIONS -------------------------




  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => '#{subject}',
        :to => ENV['gmail_username'],
        :from => %("#{name}" <#{email}>)
    }
  end
end
