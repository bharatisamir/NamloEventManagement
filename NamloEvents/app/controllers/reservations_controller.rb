class ReservationsController < ApplicationController
  layout 'reservation', :except => [:index, :show, :edit, :destroy]
  before_action :set_event
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index

    #@reservations = Reservation.all

    @event= Event.find(params[:event_id])
    @reservations = @event.reservations


    #@reservations = @event.Reservation.where(( 'event_id ? LIKE'),@event.id)
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new

    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.build

    #@reservation = Reservation.new

    @event_menu = Menu.find_by_event_id(@event.id)
    @event_menu_items = MenuItem.where(( 'menu_id LIKE ?'), @event_menu.id).all

    #@event_menu_items = MenuItem.find_by_menu_id(@event_menu.id)
    #@event_menu_items = MenuItem.where(( 'menu_id LIKE ?'), @event_menu.id)

  end

  # GET /reservations/1/edit
  def edit

    @reservation = Reservation.find(params[:id])
    #@event = Event.find(params[:event_id])
    #@reservation = @event.reservations.find(params[:id])

  end

  # POST /reservations
  # POST /reservations.json
  def create

    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.build(reservation_params)

    #@reservation = @event.reservations.create(reservation_params)
    @reservation.event_id = @event.id
    @reservation.food_choice = @event_menu.service_type

    respond_to do |format|
      if @reservation.save

        if ((@event_menu.service_type != 'Buffet') && (!@event_menu_items.empty?))
          @event_menu_items.each  do |item|
            @param_label = item.name
            if params[@param_label]!= nil
              val = params[@param_label].gsub(/\D/, '').to_i
              @quantity = item.quantity + val
              sql = "UPDATE menu_items SET quantity = #{@quantity} WHERE id = #{item.id} "
              ActiveRecord::Base.connection.execute(sql)
            end
          end
        end


        format.html { render :new, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, alert: 'Reservation was not created. All fields are required'  }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update

    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy

    @reservation = Reservation.find(params[:id])
    #@reservation = @event.incomes.find(params[:id])
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to user_host_event_path(@event_user.id, @event_host.id, @event.id), notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

=begin
  def show_reservation_form
    render :partial => 'reservations/_reservation_form'
  end
=end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

  def set_event
    @event= Event.find(params[:event_id])
    @user = current_user
    #@event_id = @event.id
    @event_host = Host.find(@event.host_id)
    @event_user = User.find(@event_host.user_id)
    # @event_id = params[:id]
    @event_menu = Menu.find_by_event_id(@event.id)
    @event_menu_items = MenuItem.where(( 'menu_id LIKE ?'), @event_menu.id).all

  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:first_name, :last_name, :email, :complete_address, :primary_phone, :attending_event, :total_attending, :food_choice, :kids_meal_required, :need_paper_invitation, :food_allergies, :special_notes, :event_id)
    end
end
