json.extract! survey_question_response, :id, :response, :survey_id, :survey_question_id, :created_at, :updated_at
json.url survey_question_response_url(survey_question_response, format: :json)