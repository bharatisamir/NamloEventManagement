class ReviewsController < ApplicationController
  #before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :user
  before_action :set_service_provider
  #before_action :check_permissions

  load_and_authorize_resource

  def check_permissions
    authorize! :crud, @review

  end


  # GET /reviews
  # GET /reviews.json
  def index

    @reviews = Review.where(serviceprovider_id: @service_provider.id ).order('created_at DESC')


    #@reviews = Review.all


    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating_score).round(2,1)
    end


  end

  #GET id of current user
  def user
    @user = current_user
    @user_host = Host.find_by_user_id(@user.id)

    #@booking = Booking.where(( 'host_id LIKE ?'),@user_host)

    #@service_provider = params[:service_provider_id]
    #@provider_user= User.find(ServiceProvider.find(params[:service_provider_id]).user_id)
    @provider_user= User.find(ServiceProvider.find(params[:service_provider_id]).user_id)
    @provider_profile = Profile.find_by_user_id(@provider_user.id)
    #@provider_profile = Profile.where(["user_id = ?", @provider_user.user_id])

    #@user_id= current_user.id
    #@profile_id = Profile.find_by_user_id(@user_id).id
  end


  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    #@review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    #@review = Review.new(review_params)
    @review.reviewer_id = @user.id
    @review.serviceprovider_id = params[:service_provider_id]

    respond_to do |format|
      if @review.save
        format.html { redirect_to service_provider_reviews_path(@service_provider.id), notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to service_provider_reviews_path(@service_provider.id), notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to service_provider_reviews_path(@service_provider.id), notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
     # @review = Review.find(params[:id])
    end

    def set_service_provider
      @service_provider = ServiceProvider.find(params[:service_provider_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:reviewer_id, :rating_score, :comments, :serviceprovider_id)
    end
end
