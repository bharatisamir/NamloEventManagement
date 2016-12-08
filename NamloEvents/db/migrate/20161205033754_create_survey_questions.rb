class CreateSurveyQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_questions do |t|
      t.text :question
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end
