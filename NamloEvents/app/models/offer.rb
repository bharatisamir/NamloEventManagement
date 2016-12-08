class Offer < ApplicationRecord


  #--------------------- FORM VALIDATIONS -------------------------
  validates :name, :price, :original_price, :details, :terms_conditions, :expires, :service_provider_id,  presence: true

  validates_length_of :name, :maximum => 255
  validates_length_of :details, :maximum => 500
  validates_length_of :terms_conditions, :maximum => 1000

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :service_provider

  #--------------------- End of ASSOCIATIONS -------------------------

end
