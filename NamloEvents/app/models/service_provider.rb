class ServiceProvider < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :service_category,:company,:business_phone,:fax,:user_id, presence: true
  validates :user_id, uniqueness: true

  validates_length_of :service_category, :maximum => 20
  validates_length_of :company, :maximum => 50
  validates_length_of :business_phone, :minimum => 10
  validates_length_of :fax, :minimum => 10
  validates_length_of :business_phone, :maximum => 20
  validates_length_of :fax, :maximum => 20

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :user
  has_many :reviews, dependent: :destroy

  #--------------------- End of ASSOCIATIONS -------------------------

end
