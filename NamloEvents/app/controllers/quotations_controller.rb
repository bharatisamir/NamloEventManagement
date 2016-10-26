class QuotationsController < ApplicationController
  before_action :set_quotation, only: [:show, :edit, :update, :destroy]
  before_action :set_event

  # GET /quotations
  # GET /quotations.json
  def index
    @quotations = Quotation.all
  end

  # GET /quotations/1
  # GET /quotations/1.json
  def show
  end

  # GET /quotations/new
  def new
    @quotation = Quotation.new
  end

  # GET /quotations/1/edit
  def edit
  end

  # POST /quotations
  # POST /quotations.json
  def create
    @quotation = Quotation.new(quotation_params)
    @quotation.event_id = @event.id

    respond_to do |format|
      if @quotation.save
        format.html { redirect_to dashboard_index_path, notice: 'Quotation was successfully created.' }
        format.json { render :show, status: :created, location: @quotation }
      else
        format.html { render :new }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotations/1
  # PATCH/PUT /quotations/1.json
  def update
    respond_to do |format|
      if @quotation.update(quotation_params)
        format.html { redirect_to dashboard_index_path, notice: 'Quotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @quotation }
      else
        format.html { render :edit }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.json
  def destroy
    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_index_path, notice: 'Quotation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quotation
      @quotation = Quotation.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
      @host = Host.find(@event.host_id)
      @event_host_user = User.find(@host.user_id)
      @user = current_user
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def quotation_params
      params.require(:quotation).permit(:rfq_issue_date, :rfq_closing_date, :rfq_contact, :rfq_delivery_method, :services_requested, :comments, :event_id)
    end
end
