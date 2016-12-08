class BookingsController < ApplicationController
  before_action :set_user
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  #before_action :check_permissions

  #load_and_authorize_resource

  def check_permissions

    authorize! :manage, @booking
    authorize! :read, @booking
  end



  def booking_report

    @booking =  params[:event_id] + ',event_id'
    respond_to do |format|
      format.html
      format.pdf do
        pdf = BookingPdf.new(@booking)
          send_data pdf.render, filename: "event_booking#{params[:event_id]}.pdf",
                    type: "application/pdf",
                    disposition: "inline"
      end
    end
  end


  def provider_booking_report
    @provider_booking =  params[:service_provider_id] + ',service_provider_id'
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ProviderBookingPdf.new(@provider_booking)
        send_data pdf.render, filename: "event_booking#{params[:service_provider_id]}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end


  # GET /bookings
  # GET /bookings.json
  def index
    #@bookings = Booking.all
   # @service_provider_id=params[:service_provider_id]

    if params[:search]

      @user = Booking.search(params[:search])

      if params[:search_options] == 'host_email'
        @host = Host.find_by_user_id(@user)
        @events = Event.where(( 'host_id LIKE ?'),@host)
        #@event_options = @events.all.map{ |u| [u.id, u.id]}

      elsif params[:search_options] == 'provider_email'

        @service_provider = ServiceProvider.find_by_user_id(@user)
        @service_bookings = Booking.where(( 'service_provider_id LIKE ?'),@service_provider)


      elsif params[:search_options] == 'event_id'
        @event_booking = Event.find(params[:search])
        @bookings = Booking.where(( 'event_id LIKE ?'),params[:search])


      end

      #@bookings = Booking.all
      @location = request.original_url
    end

  end


  # GET /bookings/1
  # GET /bookings/1.json
  def show

  end

  # GET /bookings/new
  def new
    @service_provider_id = params[:service_provider_id]
    @user = Booking.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
    @event_options = @events.all.map{ |u| [u.id, u.id]}
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
    @location = params[:location]
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.service_provider_id = params[:service_provider_id]

    if params[:offer_id] != nil
      @booking.offer_id = params[:offer_id]
    end

    respond_to do |format|
      if @booking.save
        format.html { redirect_to service_providers_path, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    @location = params[:location]
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @location, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @location = params[:location]
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to @location, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def set_provider
      @service_provider_id = params[:service_provider_id]
    end

    def set_user
      @user = current_user
      @current_host = Host.find_by_user_id(@user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:booked_date, :event_id, :service_provider_id, :offer_id, :location)
    end
end

