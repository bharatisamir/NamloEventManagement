class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_host
  #before_action :set_quotation
  #before_action :set_event, except: [:create]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all.order("created_at desc").paginate(page: params[:page], per_page:12)
    #@events = @host.Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show

  end

  # GET /events/new
  def new
    @event = Event.new
    #@host = Host.find(params[:host_id])

  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
   # @event = @host.events.create(event_params)
    @event.host_id = @host.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to dashboard_index_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to dashboard_index_path, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    #@event = @host.events.find(params[:host_id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_index_path, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

  def set_host
    @host = Host.find(params[:host_id])
    @user = current_user
    @host_id = @host.id
  end


  def set_quotation
    @event_quotations = Event.find_by_host_id(params[:host_id])

    @event_quotations.each do |event_quotation|

    end
    @quotation = Quotation.find_by_event_id(@event_quotation.id)
  end

  def set_event
      @event = Event.find(params[:id])
      #@event = @host.events.find(params[:host_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:event_name, :event_date, :event_start_time, :event_end_time, :street_address, :city, :state_province, :zip_postal_code, :country_region, :event_contact, :comments, :publish_on_marketplace, :host_id, :venue)
    end
end
