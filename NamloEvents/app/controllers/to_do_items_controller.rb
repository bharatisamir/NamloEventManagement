class ToDoItemsController < ApplicationController
  #before_action :set_to_do_item, only: [:show, :edit, :update, :destroy]
  before_action :set_to_do_list
  before_action :set_to_do_item, except: [:create]
  #before_action :check_permissions


  def check_permissions
    #authorize! :index, @to_do_list
    #authorize! :manage, @to_do_list
    authorize! :crud, @to_do_list
  end


  # GET /to_do_items
  # GET /to_do_items.json
  def index
    @to_do_items = @to_do_list.ToDoItem.all
    authorize! :index, @to_do_item
    #@to_do_items = ToDoItem.all
    #@to_do_list = ToDoList.find(params[:to_do_list_id])
  end

  # GET /to_do_items/1
  # GET /to_do_items/1.json
  def show

  end

  # GET /to_do_items/new
  def new

    @to_do_list = ToDoList.find(params[:to_do_list_id])
    #@to_do_item = @to_do_list.to_do_items.new

    #@to_do_item = ToDoItem.new
    #@to_do_list = ToDoList.find(params[:to_do_list_id])
    #@to_do_item = @to_do_list.ToDoItem.new
  end

  # GET /to_do_items/1/edit
  def edit
    #authorize! :update, @to_do_item
    @to_do_list = ToDoList.find(params[:to_do_list_id])
    @to_do_item = @to_do_list.to_do_items.find(params[:id])


  end

  # POST /to_do_items
  # POST /to_do_items.json
  def create
    #@to_do_item = ToDoItem.new(to_do_item_params)
    @to_do_item = @to_do_list.to_do_items.create(to_do_item_params)
    @to_do_item.to_do_list_id = @to_do_list.id
    #@to_do_item.to_do_list_id = params[:id]

    respond_to do |format|
      if @to_do_item.save
        format.html { redirect_to user_to_do_list_path(@to_do_list.user_id,@to_do_list.id), notice: 'To do item was successfully created.' }
        format.json { render :show, status: :created, location: @to_do_item }
      else
        format.html { render :new }
        format.json { render json: @to_do_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /to_do_items/1
  # PATCH/PUT /to_do_items/1.json
  def update
    respond_to do |format|
      if @to_do_item.update(to_do_item_params)
        format.html { redirect_to user_to_do_list_path(@to_do_list.user_id,@to_do_list.id), notice: 'To do item was successfully updated.' }
        format.json { render :show, status: :ok, location: @to_do_item }
      else
        format.html { render :edit }
        format.json { render json: @to_do_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /to_do_items/1
  # DELETE /to_do_items/1.json
  def destroy
    @to_do_item = @to_do_list.to_do_items.find(params[:id])
    @to_do_item.destroy
    respond_to do |format|
      format.html { redirect_to user_to_do_list_path(@to_do_list.user_id,@to_do_list.id), notice: 'To do item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def complete
    @to_do_item.update_attribute(:completed_at, Time.now)

    respond_to do |format|
      format.html { redirect_to user_to_do_list_path(@to_do_list.user_id,@to_do_list.id), notice: 'Todo item was successfully completed.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_to_do_list
     #@to_do_list = ToDoList.find(params[:id])
     @to_do_list = ToDoList.find(params[:to_do_list_id])
     @user = current_user
     @to_do_list_id = @to_do_list.id

    end

    def set_to_do_item

      @to_do_item = @to_do_list.to_do_items.find(params[:id])
      #@to_do_item = @to_do_list.to_do_items.new

      #@to_do_items = @to_do_list.ToDoItem.all

      #@to_do_item = @to_do_list.to_do_items.build(to_do_item_params)


      #@to_do_item = @to_do_list.to_do_items.find(params[:id])
      #@new_to_do_item = @to_do_list.to_do_items.build
      #@to_do_item = ToDoItem.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def to_do_item_params

      params.require(:to_do_item).permit(:todo_item, :completed_at, :to_do_list_id)
    end
end
