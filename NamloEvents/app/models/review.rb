class Review < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :reviewer_id,:rating_score,:comments,:serviceprovider_id, presence: true

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :service_provider

  #--------------------- End of ASSOCIATIONS -------------------------


end
