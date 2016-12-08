class EventOrderDetailsController < ApplicationController
  before_action :set_event_order
  #before_action :set_event_order_detail, only: [:show, :edit, :update, :destroy]

  #load_and_authorize_resource

  # GET /event_order_details
  # GET /event_order_details.json
  def index
    #@event_order_details = EventOrderDetail.all

=begin
    if params[:search]
      @event_order_details = EventOrderDetail.all
    else
      @event_order_details = EventOrderDetail.where(( 'event_id LIKE ?'),params[:search2])
    end

    @user = EventOrderDetail.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)

    @event_options = @events.all.map{ |u| [u.id, u.id]}
=end
   # @event_option = @events.all

    @event_order_detail = @event_order.EventOrderDetail.where(( 'event_order_id ? LIKE'),@event_order.id)

  end

  # GET /event_order_details/1
  # GET /event_order_details/1.json
  def show
  end

  # GET /event_order_details/new
  def new
=begin
    @user = EventOrderDetail.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
    @event_options = @events.all.map{ |u| [u.id, u.id]}

    if params[:event_id]
      @event = Event.find(params[:event_id])
      #@event_bookings = Booking.where(( 'event_id LIKE ?'),params[:event_id])
      @event_order = EventOrder.where(( 'event_id LIKE ?'),params[:event_id])
      @selected = params[:event_id]

    end
    #@event_bookings = Booking.where(( 'event_id LIKE ?'),params[:event_id])
    #@event_bookings = Event.where(( 'id LIKE ?'),params[:event_id])
    @event_order_detail = EventOrderDetail.new
=end
    @event_order_detail = EventOrderDetail.find(params[:@event_order])

  end

  # GET /event_order_details/1/edit
  def edit
    @event_order = EventOrder.find(params[:event_order_id])

    @event_order_detail =@event_order.event_order_details.find(params[:id])

  end

  # POST /event_order_details
  # POST /event_order_details.json
  def create

    @event_order_detail = @event_order.event_order_details.create(event_order_detail_params)
    @event_order_detail.event_order_id = @event_order.id
    @event_order_detail.service_location = @event_order.event.venue
    @event_order_detail.service_date = @event_order.event.event_date

    #@event_order_detail = EventOrderDetail.new(event_order_detail_params)

    respond_to do |format|
      if @event_order_detail.save
        format.html { redirect_to event_order_path(@event_order.id), notice: 'Event order detail was successfully created.' }
        format.json { render :show, status: :created, location: @event_order_detail }
      else
        format.html { redirect_to event_order_path(@event_order.id), alert: 'Event order detail was not created.'  }
        #format.html { render :new }
        format.json { render json: @event_order_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_order_details/1
  # PATCH/PUT /event_order_details/1.json
  def update
    respond_to do |format|
      if @event_order_detail.update(event_order_detail_params)
        format.html { redirect_to event_order_path(@event_order.id), notice: 'Event order detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_order_detail }
      else
        format.html { render :edit }
        format.json { render json: @event_order_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_order_details/1
  # DELETE /event_order_details/1.json
  def destroy

    @event_order_detail = @event_order.event_order_details.find(params[:id])
    @event_order_detail.destroy
    respond_to do |format|
      format.html { redirect_to event_order_path(@event_order.id), notice: 'Event order detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_event
    @event_bookings = Event.where(( 'event_id LIKE ?'),params[:event_id])
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_order_detail
      @event_order_detail = EventOrderDetail.find(params[:id])
    end

  def set_event_order
    @event_order= EventOrder.find(params[:event_order_id])
    @user = current_user

    #@event_bookings = Booking.where(( 'event_id LIKE ?'),@event_order.event_id)
    #@event_bookings_options = @event_bookings.all.map{ |u| [u.service_provider_id, u.service_provider_id]}

    #@event_id = @event.id
    #@event_host = Host.find(@event)
    #@event_user = User.find(@event_host)
    # @event_id = params[:id]

  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_order_detail_params
      params.require(:event_order_detail).permit(:service_date, :service_start_time, :service_end_time, :function, :service_location, :service_setup_requirements, :event_order_id, :service_id, :service_provider_id)
    end
end
