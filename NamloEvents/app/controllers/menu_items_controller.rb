class MenuItemsController < ApplicationController
  before_action :set_menu
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]
 # before_action :check_permissions

  def check_permissions
    authorize! :crud, @menu_item
  end



  # GET /menu_items
  # GET /menu_items.json
  def index
    @menu = Menu.find(params[:menu_id])
    @menu_items = @menu.menu_items
  end

  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
  end

  # GET /menu_items/new
  def new
    @menu = Menu.find(params[:menu_id])
    #@menu_item = MenuItem.new
    #@menu_item = MenuItem.find(params[:@menu])
    @menu_item = @menu.menu_items.build
    #@menu_item = MenuItem.new(:menu => @menu)
  end

  # GET /menu_items/1/edit
  def edit

=begin
    @menu = Menu.find(params[:menu_id])
    @menu_item =@menu.menu_items.find(params[:id])
=end

    @menu_item = MenuItem.find(params[:id])

  end

  # POST /menu_items
  # POST /menu_items.json
  def create
    #@menu_item = MenuItem.new(menu_item_params)
    @menu = Menu.find(params[:menu_id])

    @menu_item = @menu.menu_items.build(menu_item_params)

    #@menu_item = @menu.menu_items.build(params[:menu_item])

    #@menu_item = @menu.menu_items.create(menu_item_params)
    @menu_item.menu_id = @menu.id

    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to menu_path(@menu.id), notice: 'Menu item was successfully created.' }
        format.json { render :show, status: :created, location: @menu_item }
      else
        format.html { redirect_to menu_path(@menu.id), alert: 'Menu item was not created.', flash:{error_message: @menu_item.errors} }
        #format.html { render :new }
        #format.html { redirect_to menu_path(@menu.id)}
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_items/1
  # PATCH/PUT /menu_items/1.json
  def update

    @menu_item = MenuItem.find(params[:id])

    respond_to do |format|
      if @menu_item.update(menu_item_params)
        format.html { redirect_to menu_path(@menu.id), notice: 'Menu item was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu_item }
      else
        format.html { render :edit }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    @menu_item = MenuItem.find(params[:id])

    @menu_item.destroy
    #@menu_item = @menu.menu_items.find(params[:id])

    respond_to do |format|
      format.html { redirect_to menu_path(@menu.id), notice: 'Menu item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

  def set_menu
    @menu = Menu.find(params[:menu_id])
    @user = current_user

  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :description, :quantity, :menu_id)
    end
end
