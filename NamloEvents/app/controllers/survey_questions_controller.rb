class SurveyQuestionsController < ApplicationController
  before_action :set_survey
  before_action :set_survey_question, only: [:show, :edit, :update, :destroy]

  # GET /survey_questions
  # GET /survey_questions.json
  def index
    #@survey_questions = SurveyQuestion.all
    @survey = Survey.find(params[:survey_id])
    @survey_questions = @survey.survey_questions

  end

  # GET /survey_questions/1
  # GET /survey_questions/1.json
  def show
  end

  # GET /survey_questions/new
  def new
    @survey = Survey.find(params[:survey_id])
    @survey_question = @survey.survey_questions.build
  end

  # GET /survey_questions/1/edit
  def edit
    @survey_question = SurveyQuestion.find(params[:id])
  end

  # POST /survey_questions
  # POST /survey_questions.json
  def create

    @survey = Survey.find(params[:survey_id])
    @survey_question = @survey.survey_questions.build(survey_question_params)
    #@survey_question = SurveyQuestion.new(survey_question_params)
    @survey_question.survey_id = @survey.id

    respond_to do |format|
      if @survey_question.save
        format.html { redirect_to survey_path(@survey.id), notice: 'Survey question was successfully created.' }
        format.json { render :show, status: :created, location: @survey_question }
      else
        format.html { redirect_to survey_path(@survey.id), alert: 'Survey question was not created.', flash:{error_message: @survey_question.errors} }
       # format.html { render :new }
        format.json { render json: @survey_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /survey_questions/1
  # PATCH/PUT /survey_questions/1.json
  def update

    @survey_question = SurveyQuestion.find(params[:id])
    respond_to do |format|
      if @survey_question.update(survey_question_params)
        format.html { redirect_to survey_path(@survey.id), notice: 'Survey question was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey_question }
      else
        format.html { render :edit }
        format.json { render json: @survey_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_questions/1
  # DELETE /survey_questions/1.json
  def destroy
    @survey_question = SurveyQuestion.find(params[:id])
    @survey_question.destroy
    respond_to do |format|
      format.html { redirect_to survey_path(@survey.id), notice: 'Survey question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey_question
      @survey_question = SurveyQuestion.find(params[:id])
    end

  def set_survey
    @survey = Survey.find(params[:survey_id])
    @user = current_user

  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_question_params
      params.require(:survey_question).permit(:question, :survey_id)
    end
end
