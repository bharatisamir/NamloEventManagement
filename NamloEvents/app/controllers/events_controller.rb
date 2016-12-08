class EventsController < ApplicationController

  load_and_authorize_resource

  #before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_host
  #before_action :set_quotation
  #before_action :set_event, except: [:create]
  #before_action :check_permissions

  #prawnto :prawn => { :top_margin => 75 }


  def check_permissions
    #authorize! :read, @quotation
    authorize! :manage, @event
  end

  def event_report
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = GuestListPdf.new(@event)
        send_data pdf.render, filename: "event_#{@event.id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end


  def expense_report
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ExpensePdf.new(@event, view_context)
        send_data pdf.render, filename: "event_expense#{@event.id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  def revenue_report
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = RevenueReportPdf.new(@event, view_context)
        send_data pdf.render, filename: "event_revenue#{@event.id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  def reserved_guest_report
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReservationPdf.new(@event)
        send_data pdf.render, filename: "event_guest_reservation#{@event.id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end



  def mail_invitation
    if params[:event_id]
      @event = Event.find(params[:event_id])
      #@recipients = GuestList.where(('event_id ? LIKE'),@event.id )
      #@event_invitation = Invitation.where(('event_id ? LIKE'),@event.id )
      #SendEmailJob.send(wait: 30.seconds).perform_later(@recipients)
      NamloMailer.invitation_email(@event,current_user).deliver

      respond_to do |format|
        if $message = 200
          format.html { redirect_to  dashboard_index_path, notice: 'Invitation was successfully send.' }
        else
          format.html { redirect_to dashboard_index_path, alert: 'Invitation was not send.'  }
        end
      end

    end
  end


  # GET /events
  # GET /events.json
  def index
    #@events = Event.all.order("created_at desc").paginate(page: params[:page], per_page:12)
    #@events = Event.search(params[:search])
    #@events = @host.Event.all

    if params[:event_manager] != nil
      @managed_events = Event.where(('event_manager_id LIKE ? '), params[:event_manager])
      @events = @managed_events.all.order("created_at desc").paginate(page: params[:page], per_page:12)
    else
      @host_events = Event.where(('host_id LIKE ? '), params[:host_id])
      @events = @host_events.all.order("created_at desc").paginate(page: params[:page], per_page:12)
    end


  end

  # GET /events/1
  # GET /events/1.json
  def show

    if params[:event_id]
      @event = Event.find(params[:event_id])
      @expense = Expense.new(:event=> @event)
      @income = Income.new(:event=> @event)
      @guest_list = GuestList.new(:event=> @event)
      @reservation = Reservation.new(:event=> @event)
      @invitation = Invitation.where(event_id: @event.id).or(Invitation.where(event_two_id: @event.id)).or(Invitation.where(event_three_id: @event.id)).to_a

    else
      @event = Event.find(params[:id])
      @expense = Expense.new(:event=> @event)
      @income = Income.new(:event=> @event)
      @guest_list = GuestList.new(:event=> @event)
      @reservation = Reservation.new(:event=> @event)
      @invitation = Invitation.where(event_id: @event.id).or(Invitation.where(event_two_id: @event.id)).or(Invitation.where(event_three_id: @event.id)).to_a

    end



    #@event= Event.find(params[:event_id])

    #@expenses = Expense.new(:event=> @event)

    @form_error = []

    if flash[:error_message] != nil
      @count = flash[:error_message].count
      @message = 'error(s) prohibited this menu_item from being saved:'

      flash[:error_message].each do |err|
        #@count = err.count
        err_message1 = err[0].to_s
        err_message2 = err[1].to_s.tr('[', '').tr(']', '').tr('"', '')
        err_message = err_message1 + ' ' + err_message2

        @form_error.push(err_message)
      end

    end

  end

  # GET /events/new
  def new
    #@event = Event.new
    #@host = Host.find(params[:host_id])

  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    #@event = Event.new(event_params)
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

    if params[:event_manager] != nil
      @managed_events = Event.where(('event_manager_id LIKE ? '), params[:event_manager])
    else
      @host = Host.find(params[:host_id])
      @user = current_user
      @host_id = @host.id
    end


  end


  def set_quotation
    @event_quotations = Event.find_by_host_id(params[:host_id])

    @event_quotations.each do |event_quotation|

    end
    @quotation = Quotation.find_by_event_id(@event_quotation.id)
  end

  def set_event

    if params[:event_id]
      @event = Event.find(params[:event_id])
    else
      @event = Event.find(params[:id])
    end

      #@event = @host.events.find(params[:host_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:event_name, :event_date, :event_start_time, :event_end_time, :street_address, :city, :state_province, :zip_postal_code, :country_region, :event_contact, :comments, :publish_on_marketplace, :host_id, :venue, :image)
    end
end
