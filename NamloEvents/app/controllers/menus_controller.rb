class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  #before_action :check_permissions

  load_and_authorize_resource

  def check_permissions
    authorize! :crud, @menu
  end


  def reserved_menu_report
    @menu = Menu.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = MenuPdf.new(@menu)
        send_data pdf.render, filename: "event_menu_reservation#{@menu.event_id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end



  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all.order("created_at desc").paginate(page: params[:page], per_page:12)
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menu = Menu.find(params[:id])
    @menu_item = MenuItem.new(:menu => @menu)

    @form_error = []


    if flash[:error_message] != nil
      @count = flash[:error_message].count
      @message = 'error(s) prohibited this menu_item from being saved:'

      flash[:error_message].each do |err|
        #@count = err.count
        err_message1 = err[0].to_s
        err_message2 = err[1].to_s.tr('[', '').tr(']', '').tr('"', '')
        err_message = err_message1 + ' ' + err_message2

        @form_error.push(err_message)
      end

    end




    end

  # GET /menus/new
  def new
    @user = EventOrder.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
    @event_options = @events.all.map{ |u| [u.id, u.id]}
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to menus_path, notice: 'Menu was successfully created.' }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to menus_path, notice: 'Menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_path, notice: 'Menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :event_id, :service_type, :require_reservation)
    end

  def redirect_if_not_current_user
    if params[:user_id] != current_user.name
      redirect_to dashboard_index_path current_user.name
    end
  end

end
