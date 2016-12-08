class SurveyQuestionResponsesController < ApplicationController

  before_action :set_survey_question_response, only: [:show, :edit, :update, :destroy]



  # GET /survey_question_responses
  # GET /survey_question_responses.json
  def index
    @survey = Survey.find(1)
    @survey_question_responses = SurveyQuestionResponse.all
  end

  # GET /survey_question_responses/1
  # GET /survey_question_responses/1.json
  def show
  end

  # GET /survey_question_responses/new
  def new
    @survey = Survey.find(params[:survey_id])
    #@survey = Survey.find(1)
    @survey_question_response = SurveyQuestionResponse.new
    @survey_questions = SurveyQuestion.select('*').where(('survey_id LIKE ?'), 1)
  end

  # GET /survey_question_responses/1/edit
  def edit
  end

  # POST /survey_question_responses
  # POST /survey_question_responses.json
  def create

    @survey_question_response = SurveyQuestionResponse.new(survey_question_response_params)
    @survey_questions = SurveyQuestion.select('*').where(('survey_id LIKE ?'), 1)

    respond_to do |format|

      if @survey_question_response.save

        if (!@survey_questions.empty?)

          if params[:'1'] != nil
            @question_response = params[:'1']
            sql = "INSERT INTO survey_question_responses (response, survey_id, survey_question_id) VALUES ( #{@question_response}, #{1}, #{1})"
            ActiveRecord::Base.connection.execute(sql)
          end

          if params[:'2'] != nil

            @question_response = params[:'2']
            object = SurveyQuestionResponse.new(:response =>@question_response, :survey_id => 1, :survey_question_id => 2)
            object.save

=begin
            sql = "INSERT INTO survey_question_responses (response, survey_id, survey_question_id) VALUES ( #{@question_response.to_s}, #{1}, #{2})"
            ActiveRecord::Base.connection.execute(sql)
=end
          end

          if params[:'3'] != nil
            @question_response = params[:'3']
            object = SurveyQuestionResponse.new(:response =>@question_response, :survey_id => 1, :survey_question_id => 3)
            object.save

=begin
            sql = "INSERT INTO survey_question_responses (response, survey_id, survey_question_id) VALUES ( #{@question_response}, #{1}, #{3},)"
            ActiveRecord::Base.connection.execute(sql)
=end

          end

          if params[:'4'] != nil
            @question_response = params[:'4']
            object = SurveyQuestionResponse.new(:response =>@question_response, :survey_id => 1, :survey_question_id => 4)
            object.save

=begin
            sql = "INSERT INTO survey_question_responses (response, survey_id, survey_question_id) VALUES ( #{@question_response}, #{1}, #{4})"
            ActiveRecord::Base.connection.execute(sql)
=end

          end

          if params[:'5'] != nil
            @question_response = params[:'5']
            object = SurveyQuestionResponse.new(:response =>@question_response, :survey_id => 1, :survey_question_id => 5)
            object.save

=begin
            sql = "INSERT INTO survey_question_responses (response, survey_id, survey_question_id) VALUES ( #{@question_response}, #{1}, #{5})"
            ActiveRecord::Base.connection.execute(sql)
=end

          end

          if params[:'6'] != nil
            @question_response = params[:'6']
            object = SurveyQuestionResponse.new(:response =>@question_response, :survey_id => 1, :survey_question_id => 6)
            object.save

=begin
            sql = "INSERT INTO survey_question_responses (response, survey_id, survey_question_id) VALUES ( #{@question_response}, #{1}, #{6})"
            ActiveRecord::Base.connection.execute(sql)
=end

          end

          if params[:'7'] != nil
            @question_response = params[:'7']
            object = SurveyQuestionResponse.new(:response =>@question_response, :survey_id => 1, :survey_question_id => 7)
            object.save

=begin
            sql = "INSERT INTO survey_question_responses (response, survey_id, survey_question_id) VALUES ( #{@question_response}, #{1}, #{7})"
            ActiveRecord::Base.connection.execute(sql)
=end

          end

          if params[:'8'] != nil
            @question_response = params[:'8']
            object = SurveyQuestionResponse.new(:response =>@question_response, :survey_id => 1, :survey_question_id => 8)
            object.save

=begin
            sql = "INSERT INTO survey_question_responses (response, survey_id, survey_question_id) VALUES ( #{@question_response}, #{1}, #{8})"
            ActiveRecord::Base.connection.execute(sql)
=end

          end


          if params[:'9'] != nil
            @question_response = params[:'9']
            object = SurveyQuestionResponse.new(:response =>@question_response, :survey_id => 1, :survey_question_id => 9)
            object.save

=begin
            sql = "INSERT INTO survey_question_responses (response, survey_id, survey_question_id) VALUES ( #{@question_response}, #{1}, #{9})"
            ActiveRecord::Base.connection.execute(sql)
=end

          end

          if params[:'10'] != nil
            @question_response = params[:'10']
            object = SurveyQuestionResponse.new(:response =>@question_response, :survey_id => 1, :survey_question_id => 10)
            object.save

=begin
            sql = "INSERT INTO survey_question_responses (response, survey_id, survey_question_id) VALUES ( #{@question_response}, #{1}, #{10})"
            ActiveRecord::Base.connection.execute(sql)
=end

          end


        end

        format.html { redirect_to dashboard_index_path, notice: 'Survey question response was successfully created.' }
        format.json { render :show, status: :created, location: @survey_question_response }
      else
        format.html { render :new }
        format.json { render json: @survey_question_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /survey_question_responses/1
  # PATCH/PUT /survey_question_responses/1.json
  def update
    respond_to do |format|
      if @survey_question_response.update(survey_question_response_params)
        format.html { redirect_to dashboard_index_path, notice: 'Survey question response was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey_question_response }
      else
        format.html { render :edit }
        format.json { render json: @survey_question_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_question_responses/1
  # DELETE /survey_question_responses/1.json
  def destroy
    @survey_question_response.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_index_path, notice: 'Survey question response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey_question_response
      @survey_question_response = SurveyQuestionResponse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_question_response_params
      #params.require(:survey_question_response)
      #params.require(:survey_question_response).permit(:response, :survey_id, :survey_question_id)
    end
end
