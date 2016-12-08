class GuestListsController < ApplicationController
  before_action :set_event
  before_action :set_guest_list, only: [:show, :edit, :update, :destroy]

  # GET /guest_lists
  # GET /guest_lists.json
  def index
    #@guest_lists = GuestList.all
=begin
    if params[:search]
      @guest_lists = GuestList.all
    else
      #@expenses = Expense.search(params[:search2])
      @guest_lists = GuestList.where(( 'event_id LIKE ?'),params[:search2])
    end

    @user = GuestList.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
=end

    @event= Event.find(params[:event_id])
    @guest_lists = @event.guest_lists
    #@guest_lists = @event.GuestList.where(( 'event_id ? LIKE'),@event.id)

  end

  # GET /guest_lists/1
  # GET /guest_lists/1.json
  def show
  end

  # GET /guest_lists/new
  def new
=begin
    @user = GuestList.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
    @guest_list = GuestList.new
=end

    @event = Event.find(params[:event_id])
    @guest_list = @event.guest_lists.build

  end

  # GET /guest_lists/1/edit
  def edit
    #@event = Event.find(params[:event_id])
    #@guest_list = @event.expenses.find(params[:id])
    @guest_list = GuestList.find(params[:id])

  end

  # POST /guest_lists
  # POST /guest_lists.json
  def create

    @event = Event.find(params[:event_id])
    @guest_list = @event.guest_lists.build(guest_list_params)
    @guest_list.event_id = @event.id

    #@guest_list = GuestList.new(guest_list_params)

    respond_to do |format|
      if @guest_list.save
        format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), notice: 'Guest list was successfully created.' }
        format.json { render :show, status: :created, location: @guest_list }
      else

        format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), alert: 'Guest List was not created.', flash:{error_message: @guest_list.errors} }
        # format.html { render :new }
        #format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), alert: 'Guest list was not created.'  }
        format.json { render json: @guest_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guest_lists/1
  # PATCH/PUT /guest_lists/1.json
  def update

    @guest_list = GuestList.find(params[:id])
    respond_to do |format|
      if @guest_list.update(guest_list_params)
        format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), notice: 'Guest list was successfully updated.' }
        format.json { render :show, status: :ok, location: @guest_list }
      else
        format.html { render :edit }
        format.json { render json: @guest_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guest_lists/1
  # DELETE /guest_lists/1.json
  def destroy

    @guest_list = GuestList.find(params[:id])
    #@guest_list = @event.guest_lists.find(params[:id])
    @guest_list.destroy

    respond_to do |format|
      format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), notice: 'Guest list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest_list
      @guest_list = GuestList.find(params[:id])
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
    def guest_list_params
      params.require(:guest_list).permit(:first_name, :last_name, :email, :total_attendees_expected, :seating_arrangement, :notes, :event_id)
    end
end
