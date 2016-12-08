class RemoveCreatedAtFromSurveyQuestionResponses < ActiveRecord::Migration[5.0]
  def change
    remove_column :survey_question_responses, :created_at, :timestamps
  end
end
