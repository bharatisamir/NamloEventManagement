class PortfoliosController < ApplicationController
  before_action :set_service_provider
  #before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
  #before_action :check_permissions

  load_and_authorize_resource


  def check_permissions
    authorize! :manage, @portfolio
    authorize! :read, @portfolio
  end

  # GET /portfolios
  # GET /portfolios.json
  def index
    @portfolios = Portfolio.all
  end

  # GET /portfolios/1
  # GET /portfolios/1.json
  def show
    @gallery = Gallery.where((' portfolio_id LIKE ? '), @portfolio.id).first
    @images = Picture.where((' gallery_id LIKE ? '), @gallery.id).all

  end

  # GET /portfolios/new
  def new
    #@portfolio = Portfolio.new
  end

  # GET /portfolios/1/edit
  def edit
  end

  # POST /portfolios
  # POST /portfolios.json
  def create
    #@portfolio = Portfolio.new(portfolio_params)
    @portfolio.service_provider_id = @service_provider.id

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to service_provider_portfolio_path(@service_provider.id,@portfolio.id), notice: 'Portfolio was successfully created.' }
        format.json { render :show, status: :created, location: @portfolio }
      else
        format.html { render :new }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portfolios/1
  # PATCH/PUT /portfolios/1.json
  def update
    respond_to do |format|
      if @portfolio.update(portfolio_params)
        format.html { redirect_to service_provider_portfolio_path(@service_provider.id,@portfolio.id), notice: 'Portfolio was successfully updated.' }
        format.json { render :show, status: :ok, location: @portfolio }
      else
        format.html { render :edit }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolios/1
  # DELETE /portfolios/1.json
  def destroy
    @portfolio.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_index_path, notice: 'Portfolio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio
      #@portfolio = Portfolio.find(params[:id])
    end

    def set_service_provider
      @service_provider = ServiceProvider.find(params[:service_provider_id])
      @provider_user = User.find(@service_provider.user_id)
      @profile = Profile.find_by_user_id(@provider_user.id)
      @service_provider_service = ServiceProviderService.where((' service_provider_id LIKE ? '), @service_provider.id).first

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portfolio_params
      params.require(:portfolio).permit(:tag_line, :bio, :website, :work_experience, :achievements, :area_of_expertise, :services_offered, :works_projects, :service_provider_id)
    end
end
