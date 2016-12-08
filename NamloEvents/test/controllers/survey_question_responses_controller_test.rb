require 'test_helper'

class SurveyQuestionResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survey_question_response = survey_question_responses(:one)
  end

  test "should get index" do
    get survey_question_responses_url
    assert_response :success
  end

  test "should get new" do
    get new_survey_question_response_url
    assert_response :success
  end

  test "should create survey_question_response" do
    assert_difference('SurveyQuestionResponse.count') do
      post survey_question_responses_url, params: { survey_question_response: { response: @survey_question_response.response, survey_id: @survey_question_response.survey_id, survey_question_id: @survey_question_response.survey_question_id } }
    end

    assert_redirected_to survey_question_response_url(SurveyQuestionResponse.last)
  end

  test "should show survey_question_response" do
    get survey_question_response_url(@survey_question_response)
    assert_response :success
  end

  test "should get edit" do
    get edit_survey_question_response_url(@survey_question_response)
    assert_response :success
  end

  test "should update survey_question_response" do
    patch survey_question_response_url(@survey_question_response), params: { survey_question_response: { response: @survey_question_response.response, survey_id: @survey_question_response.survey_id, survey_question_id: @survey_question_response.survey_question_id } }
    assert_redirected_to survey_question_response_url(@survey_question_response)
  end

  test "should destroy survey_question_response" do
    assert_difference('SurveyQuestionResponse.count', -1) do
      delete survey_question_response_url(@survey_question_response)
    end

    assert_redirected_to survey_question_responses_url
  end
end
