class RemoveUpdatedAtFromSurveyQuestionResponses < ActiveRecord::Migration[5.0]
  def change
    remove_column :survey_question_responses, :updated_at, :timestamps
  end
end
