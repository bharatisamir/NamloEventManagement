class IncomesController < ApplicationController
  before_action :set_event
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  # GET /incomes
  # GET /incomes.json
  def index
=begin
    event = Event.find(params[:event_id])
    @incomes = event.incomes
    #@incomes = Income.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @incomes}

    end
=end

    @event= Event.find(params[:event_id])
    @incomes = @event.incomes

    #@income = @event.Income.where(( 'event_id ? LIKE'),@event.id)

=begin
    if params[:search]
      @incomes = Income.all
    else
      @incomes = Income.where(( 'event_id LIKE ?'),params[:search2])
    end

    @user = Income.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
=end

  end

  # GET /incomes/1
  # GET /incomes/1.json
  def show
  end

  # GET /incomes/new
  def new


=begin
    @user = Income.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
    @income = Income.new
=end

    @event = Event.find(params[:event_id])
    @income = @event.incomes.build

  end

  # GET /incomes/1/edit
  def edit

    #@event = Event.find(params[:event_id])
    @income = Income.find(params[:id])


  end

  # POST /incomes
  # POST /incomes.json
  def create

    @event = Event.find(params[:event_id])
    #@income = Income.new(income_params)

    @income = @event.incomes.build(income_params)
    @income.event_id = @event.id

    respond_to do |format|
      if @income.save
        format.html { redirect_to  user_host_event_path(@event_user.id, @event_host.id, @event.id), notice: 'Income was successfully created.' }
        format.json { render :show, status: :created, location: @income }
      else

        format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), alert: 'Income was not created.', flash:{error_message: @income.errors} }
        #format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), alert: 'Expense was not created.'  }
        #format.html { render :new }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incomes/1
  # PATCH/PUT /incomes/1.json
  def update

    @income = Income.find(params[:id])

    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), notice: 'Income was successfully updated.' }
        format.json { render :show, status: :ok, location: @income }
      else
        format.html { render :edit }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incomes/1
  # DELETE /incomes/1.json
  def destroy

    #@income = @event.incomes.find(params[:id])
    @income = Income.find(params[:id])
    @income.destroy
    respond_to do |format|
      format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), notice: 'Income was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_income
      @income = Income.find(params[:id])
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
    def income_params
      params.require(:income).permit(:income_date, :income_source, :expected_amount, :actual_amount, :notes, :event_id)
    end
end
