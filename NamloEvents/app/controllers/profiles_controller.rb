class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :user

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  #GET id of current user
  def user
    @user = current_user
    @user_id= current_user.id
    @profile_id = Profile.find_by_user_id(@user_id)
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = params[:user_id]

    respond_to do |format|
      if @profile.save

        @user_id = @user.id
        if @user_id != nil
          @role = Role.find_by_name('User')
          @role_id =@role.id
          if @role_id != nil
            sql = "INSERT INTO roles_users(user_id, role_id) VALUES( #{@user_id }, #{@role_id})"
            ActiveRecord::Base.connection.execute(sql)
          end
        end

        format.html { redirect_to dashboard_index_path, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to dashboard_index_path, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:street_address, :city, :state_province, :zip_postal_code, :country_region, :home_phone, :cell_phone, :user_id, :image )
    end
end
