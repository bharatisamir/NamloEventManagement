class Reservation < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :last_name, :email, :complete_address, :primary_phone, :attending_event, :total_attending, :event_id, presence: true

  validates_length_of :special_notes, :maximum => 500
  validates_length_of :primary_phone, :maximum => 20
  validates_length_of :complete_address, :maximum => 100
  validates_length_of :first_name, :maximum => 100
  validates_length_of :last_name, :maximum => 100
  validates :email, presence: true, length: {maximum: 255},format: {with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false, :scope =>  :event_id }



  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :event

  #--------------------- End of ASSOCIATIONS -------------------------

end
