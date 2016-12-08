class OffersController < ApplicationController

  load_and_authorize_resource
  before_action :set_service_provider
  #before_action :set_offer, only: [:show, :edit, :update, :destroy]
  #before_action :check_permissions


  def check_permissions
    authorize! :crud, @offer
  end


  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all.order("created_at desc").paginate(page: params[:page], per_page:1)
    #@offers = Offer.paginate(:per_page => 1, :page => params[:page]).order('created_at DESC')

  end

  # GET /offers/1
  # GET /offers/1.json
  def show
   # @offer = Offer.find(params[:id])
  end

  # GET /offers/new
  def new
    #@offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.json
  def create
    #@offer = Offer.new(offer_params)
    @offer.service_provider_id = @service_provider.id

    respond_to do |format|
      if @offer.save
        format.html { redirect_to service_provider_offers_path(@service_provider.id), notice: 'Offer was successfully created.' }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to service_provider_offers_path(@service_provider.id), notice: 'Offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to service_provider_offers_path(@service_provider.id), notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
     # @offer = Offer.find(params[:id])
    end

  def set_service_provider
    @service_provider = ServiceProvider.find(params[:service_provider_id])
    @provider_user = User.find(@service_provider.user_id)
    @user = current_user
    @current_provider = ServiceProvider.find_by_user_id(@user.id)

  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:name, :price, :details, :terms_conditions, :expires, :service_provider_id, :original_price)
    end
end
