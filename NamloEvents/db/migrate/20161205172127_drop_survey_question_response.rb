class DropSurveyQuestionResponse < ActiveRecord::Migration[5.0]
  def up
    drop_table :survey_question_responses
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
