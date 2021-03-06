class HostsController < ApplicationController
  before_action :set_host, only: [:show, :edit, :update, :destroy]
  before_action :user

  # GET /hosts
  # GET /hosts.json
  def index
    @hosts = Host.all
  end

  #GET id of current user
  def user
    @user = current_user
    #@user_id= current_user.id
    # @profile_id = Profile.find_by_user_id(@user_id).id
  end

  # GET /hosts/1
  # GET /hosts/1.json
  def show
  end

  # GET /hosts/new
  def new
    @host = Host.new
  end

  # GET /hosts/1/edit
  def edit
  end

  # POST /hosts
  # POST /hosts.json
  def create
    @host = Host.new(host_params)
    @host.user_id = params[:user_id]

    respond_to do |format|
      if @host.save

        @user_id = @user.id
        @host_id = Host.where(('user_id LIKE ?'),@user_id)
        if @host_id != nil
          @role = Role.find_by_name('Host')
          @role_id =@role.id
          if @role_id != nil
            sql = "INSERT INTO roles_users(user_id, role_id) VALUES( #{@user_id }, #{@role_id})"
            ActiveRecord::Base.connection.execute(sql)
          end
        end

        format.html { redirect_to dashboard_index_path, notice: 'Host was successfully created.' }
        format.json { render :show, status: :created, location: @host }
      else
        format.html { render :new }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hosts/1
  # PATCH/PUT /hosts/1.json
  def update
    respond_to do |format|
      if @host.update(host_params)
        format.html { redirect_to @host, notice: 'Host was successfully updated.' }
        format.json { render :show, status: :ok, location: @host }
      else
        format.html { render :edit }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.json
  def destroy
    @host.destroy
    respond_to do |format|
      format.html { redirect_to hosts_url, notice: 'Host was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_host
      @host = Host.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def host_params
      params.permit(:user_id)
    end
end
