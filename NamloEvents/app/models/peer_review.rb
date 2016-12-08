class PeerReview < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :reviewer_id,:organization_score,:expertise_score,:professionalism_score,:time_management_score,:cooperation_score,:communication_score,:people_skills_score,:service_score,:comments,:serviceprovider_id, presence: true

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :service_provider

  #--------------------- End of ASSOCIATIONS -------------------------

end
