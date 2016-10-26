class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :user
  #before_action :check_permissions


  def check_permissions
    authorize! :crud, @review

  end


  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  #GET id of current user
  def user
    @user = current_user
    @service_provider = params[:service_provider_id]
    #@provider_user= User.find(ServiceProvider.find(params[:service_provider_id]).user_id)
    @provider_user= User.find(ServiceProvider.find(@service_provider).user_id)
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
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.reviewer_id = params[:user_id]
    @review.serviceprovider_id = params[:serviceprovider_id]

    respond_to do |format|
      if @review.save
        format.html { redirect_to dashboard_index_path, notice: 'Review was successfully created.' }
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
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
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
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:reviewer_id, :rating_score, :comments, :serviceprovider_id)
    end
end
