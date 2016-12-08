class ExpensesController < ApplicationController
  before_action :set_event
  before_action :set_expense, only: [:show, :edit, :update, :destroy]


  # GET /expenses
  # GET /expenses.json
  def index

    #@expenses = @event.Expense.where(( 'event_id ? LIKE'),@event.id)

    @event= Event.find(params[:event_id])
    @expenses = @event.expenses

=begin
   #@expenses = Expense.all
    if params[:search]
      @expenses = Expense.all

    else
      #@expenses = Expense.search(params[:search2])
      @expenses = Expense.where(( 'event_id LIKE ?'),params[:search2])
    end

    #@expenses = Expense.where(( 'event_id LIKE ?'),params[:search2])
    @user = Expense.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
=end


  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show


  end


  # GET /expenses/new
  def new

    @event = Event.find(params[:event_id])
    @expense = @event.expenses.build

   #@expense = Expense.new




=begin
    @user = Expense.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
    @expense = Expense.new
=end

  end

  # GET /expenses/1/edit
  def edit

    @expense = Expense.find(params[:id])
=begin
    @event = Event.find(params[:event_id])
    @expense = @event.expenses.find(params[:id])
=end

  end

  # POST /expenses
  # POST /expenses.json
  def create

    @event = Event.find(params[:event_id])
    @expense = @event.expenses.build(expense_params)
    #@expense = @event.expenses.create(expense_params)
    @expense.event_id = @event.id

    #@expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else

        format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), alert: 'Expense was not created.', flash:{error_message: @expense.errors} }
        #format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), alert: 'Expense was not created.'  }
        #format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update

    @expense = Expense.find(params[:id])
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy

    @expense = Expense.find(params[:id])
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      #@to_do_item = @to_do_list.to_do_items.find(params[:id])
      @expense = @event.expenses.find(params[:id])
    end

  def set_event

    @event= Event.find(params[:event_id])
    @user = current_user
    #@event_id = @event.id
    @event_host = Host.find(@event)
    @event_user = User.find(@event_host)

   # @event_id = params[:id]

  end


  # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:expense_date, :expense_source, :budgeted_amount, :actual_amount, :notes, :event_id)
    end
end
