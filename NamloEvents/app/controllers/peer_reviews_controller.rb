class PeerReviewsController < ApplicationController
 # before_action :set_peer_review, only: [:show, :edit, :update, :destroy]
  before_action :user
  before_action :set_service_provider

  load_and_authorize_resource

  #load_and_authorize_resource :service_provider
  #load_and_authorize_resource :peer_review, :through => :service_provider

  # GET /peer_reviews
  # GET /peer_reviews.json
  def index
    #@peer_reviews = PeerReview.all

    @peer_reviews = PeerReview.where(serviceprovider_id: @service_provider.id ).order('created_at DESC')



    if @peer_reviews.blank?
      @avg_organization_score = 0
      @avg_expertise_score = 0
      @avg_professionalism_score = 0
      @avg_time_management_score = 0
      @avg_cooperation_score = 0
      @avg_communication_score = 0
      @avg_people_skills_score = 0
      @avg_service_score = 0
    else
        @avg_organization_score = @peer_reviews.average(:organization_score).round(2,1)
        @avg_expertise_score = @peer_reviews.average(:expertise_score).round(2,1)
        @avg_professionalism_score = @peer_reviews.average(:professionalism_score).round(2,1)
        @avg_time_management_score = @peer_reviews.average(:time_management_score).round(2,1)
        @avg_cooperation_score = @peer_reviews.average(:cooperation_score).round(2,1)
        @avg_communication_score = @peer_reviews.average(:communication_score).round(2,1)
        @avg_people_skills_score = @peer_reviews.average(:people_skills_score).round(2,1)
        @avg_service_score = @peer_reviews.average(:service_score).round(2,1)

    end



  end

  #GET id of current user
  def user
    @user = current_user
    @provider_user = User.find(ServiceProvider.find(params[:service_provider_id]).user_id)
    @user_is_provider = ServiceProvider.find_by_user_id(@user.id)
    @provider_profile = Profile.find_by_user_id(@provider_user.id)
    #@profile_id = Profile.find_by_user_id(@user_id).id
  end

  # GET /peer_reviews/1
  # GET /peer_reviews/1.json
  def show
  end

  # GET /peer_reviews/new
  def new
    #@peer_review = PeerReview.new
  end

  # GET /peer_reviews/1/edit
  def edit
  end

  # POST /peer_reviews
  # POST /peer_reviews.json
  def create
    #@peer_review = PeerReview.new(peer_review_params)
    @peer_review.serviceprovider_id = params[:serviceprovider_id]
    @peer_review.reviewer_id = params[:reviewer_id]


    respond_to do |format|
      if @peer_review.save
        format.html { redirect_to service_provider_peer_reviews_path(@service_provider.id), notice: 'Peer review was successfully created.' }
        format.json { render :show, status: :created, location: @peer_review }
      else
        format.html { render :new }
        format.json { render json: @peer_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /peer_reviews/1
  # PATCH/PUT /peer_reviews/1.json
  def update
    respond_to do |format|
      if @peer_review.update(peer_review_params)
        format.html { redirect_to service_provider_peer_reviews_path(@service_provider.id), notice: 'Peer review was successfully updated.' }
        format.json { render :show, status: :ok, location: @peer_review }
      else
        format.html { render :edit }
        format.json { render json: @peer_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /peer_reviews/1
  # DELETE /peer_reviews/1.json
  def destroy
    @peer_review.destroy
    respond_to do |format|
      format.html { redirect_to service_provider_peer_reviews_path(@service_provider.id), notice: 'Peer review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_peer_review
     # @peer_review = PeerReview.find(params[:id])
    end

  def set_service_provider
    @service_provider = ServiceProvider.find(params[:service_provider_id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def peer_review_params
      params.require(:peer_review).permit(:reviewer_id, :organization_score, :expertise_score, :professionalism_score, :time_management_score, :cooperation_score, :communication_score, :people_skills_score, :service_score, :comments, :serviceprovider_id)
    end
end
