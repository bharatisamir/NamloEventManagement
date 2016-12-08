class GuestList < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name,:last_name,:email,:total_attendees_expected,:seating_arrangement,:event_id, presence: true
  validates_length_of :first_name, :maximum => 255
  validates_length_of :last_name, :maximum => 255
  validates_length_of :seating_arrangement, :maximum => 10
  validates_length_of :notes, :maximum => 500
  validates :email, presence: true, length: {maximum: 255},format: {with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :event

  #--------------------- End of ASSOCIATIONS -------------------------


  def self.search(search)
    if search
      @user = User.where(( 'email LIKE ?'), "%#{search}%")
    end
  end




end
