class SurveyQuestionResponse < ApplicationRecord


  #--------------------- FORM VALIDATIONS -------------------------
  #validates :question, :survey_id, :survey_question_id, :response,  presence: true


  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------

  belongs_to :survey
  belongs_to :survey_question


  #--------------------- End of ASSOCIATIONS -------------------------


end
