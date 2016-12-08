class Survey < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------
  validates :name, :description,  presence: true

  validates_length_of :name, :maximum => 255
  validates_length_of :description, :maximum => 500

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------

  has_many :survey_questions, dependent: :destroy




  #--------------------- End of ASSOCIATIONS -------------------------
end
