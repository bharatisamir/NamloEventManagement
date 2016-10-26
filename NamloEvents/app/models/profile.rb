class Profile < ApplicationRecord

  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :user
  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  #--------------------- End of ASSOCIATIONS -------------------------

  #--------------------- FORM VALIDATIONS -------------------------

  validates :street_address,:city,:state_province,:zip_postal_code,:country_region,:home_phone,:cell_phone,:user_id, presence: true
  validates :home_phone,:cell_phone,:user_id, uniqueness: true

  validates_length_of :cell_phone, :minimum => 10
  validates_length_of :home_phone, :minimum => 10
  validates_length_of :street_address, :maximum => 50
  validates_length_of :city, :maximum => 20
  validates_length_of :state_province, :maximum => 20
  validates_length_of :zip_postal_code, :maximum => 10
  validates_length_of :country_region, :maximum => 20
  validates_length_of :cell_phone, :maximum => 20
  validates_length_of :home_phone, :maximum => 20


  #--------------------- End of VALIDATIONS -------------------------






end
