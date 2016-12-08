class ServiceProvidersController < ApplicationController
  before_action :set_service_provider, only: [:show, :edit, :update, :destroy]
  before_action :user

  # GET /service_providers
  # GET /service_providers.json
  def index
    @service_providers = ServiceProvider.all.order("created_at desc").paginate(page: params[:page], per_page:12)

  end



  #GET id of current user
  def user
    @user = current_user
    @user_host = Host.find_by_user_id(@user.id)

   if (params[:id])!=nil
     @provider_user= User.find(ServiceProvider.find(params[:id]).user_id)
     @provider_profile = Profile.find_by_user_id(@provider_user.id)
   end

    @service_options = Service.all.map{ |u| [u.service_name, u.id]}

  end

  # GET /service_providers/1
  # GET /service_providers/1.json
  def show
    @reviews = Review.where(serviceprovider_id: @service_provider.id ).order('created_at DESC')


    #@reviews = Review.all

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating_score).round(2,1)
    end
  end

  # GET /service_providers/new
  def new
    @service_provider = ServiceProvider.new
  end

  # GET /service_providers/1/edit
  def edit
  end

  # POST /service_providers
  # POST /service_providers.json
  def create
    @service_provider = ServiceProvider.new(service_provider_params)
    @service_provider.user_id = params[:user_id]
    respond_to do |format|
      if @service_provider.save

        @user_id = @user.id
        @service_provider_id=ServiceProvider.where(('user_id LIKE ?'),@user_id)
        if @service_provider_id != nil
          @role = Role.find_by_name('Service_Provider')
          @role_id =@role.id
          if @role_id != nil
            sql = "INSERT INTO roles_users(user_id, role_id) VALUES( #{@user_id }, #{@role_id})"
            ActiveRecord::Base.connection.execute(sql)
          end

          if params[:service_id] != nil
            @services = params[:service_id]
            @services.each do |service|
              sql = "INSERT INTO service_provider_services(service_provider_id, service_id) VALUES( #{@user_id }, #{service})"
              ActiveRecord::Base.connection.execute(sql)
            end
          end

        end

        format.html { redirect_to dashboard_index_path, notice: 'Service provider was successfully created.' }
        format.json { render :show, status: :created, location: @service_provider }
      else
        format.html { render :new }
        format.json { render json: @service_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_providers/1
  # PATCH/PUT /service_providers/1.json
  def update
    respond_to do |format|
      if @service_provider.update(service_provider_params)
        format.html { redirect_to @service_provider, notice: 'Service provider was successfully updated.' }
        format.json { render :show, status: :ok, location: @service_provider }
      else
        format.html { render :edit }
        format.json { render json: @service_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_providers/1
  # DELETE /service_providers/1.json
  def destroy
    @service_provider.destroy
    respond_to do |format|
      format.html { redirect_to service_providers_url, notice: 'Service provider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_provider
      @service_provider = ServiceProvider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_provider_params
      params.require(:service_provider).permit(:service_id, :company, :business_phone, :fax, :user_id)
    end
end
