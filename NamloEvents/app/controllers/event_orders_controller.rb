class EventOrdersController < ApplicationController

  before_action :set_event_order, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource


  def event_order_report
    @event_order = EventOrder.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = EventOrderPdf.new(@event_order, view_context)
        send_data pdf.render, filename: "event_order#{@event_order.id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end


  # GET /event_orders
  # GET /event_orders.json
  def index
    #@event_orders = EventOrder.all
=begin
    if params[:search]
      @event_orders = EventOrder.all
    else
      #@expenses = Expense.search(params[:search2])
      @event_orders = EventOrder.where(( 'event_id LIKE ?'),params[:search2])
    end

    @user = EventOrder.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
=end


    if params[:event_manager] != nil

      @managed_event = Event.where((' manager_id LIKE ?'), params[:event_manager])


      @managed_event_order = EventOrder.where(('event_manager_id LIKE ? AND event_order_id LIKE ? '), params[:manager_id])
    end






    @event_orders = EventOrder.all

=begin
    if params[:event_manager] != nil
      @managed_event_orders = Event.EventOrder.where(('event_manager_id LIKE ? '), params[:event_manager])
      @event_orders = @managed_event_orders.all.order("created_at desc").paginate(page: params[:page], per_page:12)
    else
      @host_event_orders = Event.EventOrder.where(('host_id LIKE ? '), params[:host_id])
      @event_orders = @host_event_orders.all.order("created_at desc").paginate(page: params[:page], per_page:12)
    end
=end



  end

  # GET /event_orders/1
  # GET /event_orders/1.json
  def show
  end

  # GET /event_orders/new
  def new
    @user = EventOrder.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
    @event_options = @events.all.map{ |u| [u.id, u.id]}
    @event_order = EventOrder.new
  end

  # GET /event_orders/1/edit
  def edit
  end


  # POST /event_orders
  # POST /event_orders.json
  def create
    @event_order = EventOrder.new(event_order_params)
    respond_to do |format|
      if @event_order.save
        format.html { redirect_to event_orders_path, notice: 'Event order was successfully created.' }
        format.json { render :show, status: :created, location: @event_order }
      else
        format.html { render :new }
        format.json { render json: @event_order.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /event_orders/1
  # PATCH/PUT /event_orders/1.json
  def update
    respond_to do |format|
      if @event_order.update(event_order_params)
        format.html { redirect_to event_orders_path, notice: 'Event order was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_order }
      else
        format.html { render :edit }
        format.json { render json: @event_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_orders/1
  # DELETE /event_orders/1.json
  def destroy
    @event_order.destroy
    respond_to do |format|
      format.html { redirect_to event_orders_url, notice: 'Event order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_order
      @event_order = EventOrder.find(params[:id])
      @event_bookings = Booking.where(( 'event_id LIKE ?'),@event_order.event_id)
      #@event_bookings_options = @event_bookings.all.map{ |u| [u.service_provider_id, u.service_provider_id]}
      @service_options = Service.all.map{ |u| [u.service_name, u.id]}

      @event_service_providers = []


=begin
      if @service_provider_service != nil
        @service_provider_service.each do |service|
          @service= Service.find(service.service_id).service_name

      end
=end

      @event_bookings.each do |book|
        user_provider = User.find(ServiceProvider.find(book.service_provider_id).user_id)
        provider_name = user_provider.first_name + ' ' + user_provider.last_name

        @service_provider_service = ServiceProviderService.where((' service_provider_id LIKE ? '), book.service_provider_id).first

        provider_service =Service.find(@service_provider_service.service_id).service_name
        provider = provider_name + ' : ' + provider_service
        e = [book.service_provider_id,provider]
        @event_service_providers.push(e)
      end

      @event_bookings_options = @event_service_providers.map{ |value|[value[1], value[0]] }

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_order_params
      params.require(:event_order).permit(:order_date, :primary_onsite_contact, :secondary_onsite_contact, :primary_phone, :secondary_phone, :event_id)
    end
end
