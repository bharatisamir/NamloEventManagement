class CreateSurveyQuestionResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_question_responses do |t|
      t.string :response
      t.references :survey, foreign_key: true
      t.references :survey_question, foreign_key: true

      t.timestamps
    end
  end
end
