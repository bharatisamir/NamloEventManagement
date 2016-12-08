class SurveyQuestion < ApplicationRecord


  #--------------------- FORM VALIDATIONS -------------------------
  validates :question, :survey_id,  presence: true

  validates_length_of :question, :maximum => 500

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------

  belongs_to :survey
  has_many :survey_question_responses, dependent: :destroy


  #--------------------- End of ASSOCIATIONS -------------------------

end
