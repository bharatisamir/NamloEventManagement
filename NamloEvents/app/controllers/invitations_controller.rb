class InvitationsController < ApplicationController
 # respond_to :html, :json
  require 'uri'
  layout 'reservation', only: [:show, :event_detail]
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]

  #before_action :check_permissions

  load_and_authorize_resource


  def check_permissions
    authorize! :cud, @invitation
  end


  def event_detail

    if params[:event_id]
      @invitation_event = Event.find(params[:event_id])

      #@address= [street_address, city, state_province, country_region ].compact.join(',')
      @address = @invitation_event.street_address + ', ' +@invitation_event.city+ ', ' + @invitation_event.state_province
      @location = Geocoder.coordinates(@address)

    end




=begin
    if @invitation_event.event_id != nil
      @event_one = Event.find(@invitation_event.event_id)
    end

    if @invitation_event.event_two_id != nil
      @event_two = Event.find(@invitation_event.event_two_id)
    end

    if @invitation_event.event_three_id != nil
      @event_three = Event.find(@invitation_event.event_three_id)
    end
=end


    respond_to do |format|
      #format.js
      format.html { render 'invitations/event_detail' }

    end
  end


  # GET /invitations
  # GET /invitations.json
  def index
   # @invitations = invitation.all

    if params[:search]
      @invitations = Invitation.all
    else
      @invitations = Invitation.where(( 'event_id LIKE ?'),params[:search2])
    end

    @user = Invitation.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
    @event_options = @events.all.map{ |u| [u.id, u.id]}

  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @invitation_event = Invitation.find(params[:id])

    if @invitation_event.event_id != nil
        @event_one = Event.find(@invitation_event.event_id)
    end

    if @invitation_event.event_two_id != nil
        @event_two = Event.find(@invitation_event.event_two_id)
    end

    if @invitation_event.event_three_id != nil
        @event_three = Event.find(@invitation_event.event_three_id)
    end


    if @invitation_event.gift_tag_line != ''
      @gift_one = @invitation_event.gift_tag_line
      if @gift_one =~ URI::regexp
        @gift_one_uri = 'yes'
        uri = URI.parse(@gift_one)
        @gift_one_name = uri.host.split('.').second
      else
        @gift_one_uri = 'no'
        @gift_one_name = @invitation_event.gift_tag_line
      end


    end

    if @invitation_event.gift_tagline2 !=''
      @gift_two = @invitation_event.gift_tagline2
      if @gift_two =~ URI::regexp
        @gift_two_uri = 'yes'
        uri = URI.parse(@gift_two)
        @gift_two_name = uri.host.split('.').second
      else
        @gift_two_uri = 'no'
        @gift_two_name = @invitation_event.gift_tagline2
      end

    end

    if @invitation_event.gift_tagline3 !=''
      @gift_three = @invitation_event.gift_tagline3
      if @gift_three =~ URI::regexp
        @gift_three_uri = 'yes'
        uri = URI.parse(@gift_three)
        @gift_three_name = uri.host.split('.').second
      else
        @gift_three_uri = 'no'
        @gift_three_name = @invitation_event.gift_tagline3
      end

    end


  end

  # GET /invitations/new
  def new
    @user = Invitation.search(params[:search])
    @host = Host.find_by_user_id(@user)
    @events = Event.where(( 'host_id LIKE ?'),@host)
    @event_options = @events.all.map{ |u| [u.id, u.id]}
    @invitation = Invitation.new

  end

  # GET /invitations/1/edit
  def edit
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(invitation_params)

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @invitation, notice: 'invitation was successfully created.' }
        format.json { render :show, status: :created, location: @invitation }
      else
        format.html { render :new }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json

  def update
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @invitation, notice: 'invitation was successfully updated.' }
        #format.json { render :show, status: :ok, location: @invitation }
        format.json { respond_with_bip(@invitation) }
      else
        format.html { render :edit }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
        #format.json { respond_with_bip(@invitation) }
        #respond_with @invitation
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation.destroy
    respond_to do |format|
      format.html { redirect_to invitations_url, notice: 'invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:opening_tag_line, :groom_tag_line, :mid_tag_line, :bride_tag_line, :event_tag_line, :gift_tag_line, :closing_tag_line, :event_id, :groom_tagline2, :bride_tagline2, :mid_tagline2, :event_two_id, :event_three_id, :gift_tagline2, :gift_tagline3, :image )
    end
end
