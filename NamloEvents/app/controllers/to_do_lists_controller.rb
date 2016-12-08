class ToDoListsController < ApplicationController
  #before_action :set_to_do_list, only: [:show, :edit, :update, :destroy]
  before_action :user
  #before_action :check_permissions

  load_and_authorize_resource


  def check_permissions
    #authorize! :index, @to_do_list
    authorize! :crud, @to_do_list
  end

  # GET /to_do_lists
  # GET /to_do_lists.json
  def index
    @to_do_lists = ToDoList.all.order("created_at desc").paginate(page: params[:page], per_page:12)

    #@to_do_lists = ToDoList.select('*').where(('user_id LIKE ?'), params[:user_id]).all.order("created_at desc").paginate(page: params[:page], per_page:12)

    #authorize! :index, @to_do_list

  end

  #GET id of current user
  def user
    @user = current_user

  end

  # GET /to_do_lists/1
  # GET /to_do_lists/1.json
  def show
    @no_of_to_do = ToDoItem.select('*').where(('to_do_list_id LIKE ?'), params[:id]).distinct.count('id')
    @no_of_to_do_completed = ToDoItem.select('*').where(('to_do_list_id LIKE ?'), params[:id]).distinct.count ('completed_at')
    @no_of_to_do_remaining = @no_of_to_do - @no_of_to_do_completed
    @percentage_to_do_remaining = (( @no_of_to_do_remaining.to_f / @no_of_to_do)* 100)
    @percentage_to_do_completed = (( @no_of_to_do_completed.to_f / @no_of_to_do)* 100)
  end

  # GET /to_do_lists/new
  def new
    #@to_do_list = ToDoList.new
  end

  # GET /to_do_lists/1/edit
  def edit
    #authorize! :update, @to_do_list
  end

  # POST /to_do_lists
  # POST /to_do_lists.json
  def create

    #@to_do_list = ToDoList.new(to_do_list_params)
    @to_do_list.user_id = params[:user_id]

    respond_to do |format|
      if @to_do_list.save
        format.html { redirect_to user_to_do_lists_path, notice: 'To do list was successfully created.' }
        format.json { render :show, status: :created, location: @to_do_list }
      else
        format.html { render :new }
        format.json { render json: @to_do_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /to_do_lists/1
  # PATCH/PUT /to_do_lists/1.json
  def update
    respond_to do |format|
      if @to_do_list.update(to_do_list_params)
        format.html { redirect_to user_to_do_lists_path, notice: 'To do list was successfully updated.' }
        format.json { render :show, status: :ok, location: @to_do_list }
      else
        format.html { render :edit }
        format.json { render json: @to_do_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /to_do_lists/1
  # DELETE /to_do_lists/1.json
  def destroy
    @to_do_list.destroy
    respond_to do |format|
      format.html { redirect_to user_to_do_lists_path, notice: 'To do list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_to_do_list
      #@to_do_list = ToDoList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def to_do_list_params
      params.require(:to_do_list).permit(:todo_list_title, :todo_list_description, :user_id)
    end
end
