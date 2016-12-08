class EventOrderPdf < Prawn::Document

  def initialize(event_order, view)
    super()
    @event_order = event_order
    @view = view

    @event = Event.find(@event_order.event_id)
    @host = Host.find(@event.host_id)
    @host_user = User.find( @host.user_id)
    @profile = Profile.find_by_user_id(@host_user.id)

    @event_order_details = EventOrderDetail.where((' event_order_id LIKE ?'), @event_order.id).to_a


    company_logo
    event_title
    event_sub_title
    event_sub_title1
    report_title
    event_details
    table_title
    event_order_details

  end

  def company_logo

    @path = Rails.root + 'app/assets/images/namlo_pdf.jpg'

    image "#{@path}", :height => 89, :width => 200
  end

  def event_title
    #move_down 10
    text "#{@event.event_name}", size:25, style: :bold, :align => :center, color: '0000dd'
  end

  def report_title
    move_down 30
    text "Order Details Report", size:20, style: :bold, :align => :center, color: 'dd0055'
  end

  def event_sub_title
    move_down 1
    text "Client Phone: #{@profile.cell_phone}", size:8,:align => :center, style: :bold, color: 'dd8800'
  end

  def event_sub_title1
    move_down 1
    text "Address: #{@profile.street_address}, #{@profile.city}, #{@profile.state_province} #{@profile.zip_postal_code} ", size:8,:align => :center, style: :bold, color: 'dd8800'
  end


  def event_details

    move_down 50
    y_position = cursor
    bounding_box([1, y_position], :width => 300, :height => 80) do
      text "Order ID: #{@event_order.id}", size:12, style: :bold, color: 'dd8800'
      text "Order Date: #{@event_order.order_date}", size:12, style: :bold, color: 'dd8800'
      text "Primary Onsite Contact: #{@event_order.primary_onsite_contact}(#{@event_order.primary_phone})", size:12, style: :bold, color: 'dd8800'
      text "Secondary Onsite Contact: #{@event_order.secondary_onsite_contact}(#{@event_order.secondary_phone})", size:12, style: :bold, color: 'dd8800'
      #text "From: #{@event_order.order_date} To: #{@event_order.event_order_details.last.order_date}", size:12, style: :bold, color: 'dd8800'

    end

    bounding_box([420, y_position], :width => 200, :height => 80) do
      text "Event ID: #{@event.id}", size:12, style: :bold, color: 'dd8800'
      text "Client  ID: #{@host.id}", size:12, style: :bold, color: 'dd8800'
      text "Name: #{@host_user.first_name} #{@host_user.last_name}", size:12, style: :bold, color: 'dd8800'
      text "Report#: 1", size:12, style: :bold, color: 'dd8800'
    end

  end

  def table_title
    move_down 15
    text "Complete Event Order Details", size:15, style: :bold, color: '0000dd'
  end

  def event_order_details
    move_down 5

    table(event_order_detail_rows, :column_widths => {0 => 50, 1 => 50, 2 => 50, 3 => 50},:cell_style =>{:size => 8,  }) do
      cells.borders = []
      row(0).font_style = :bold
      row(0).background_color = '7100aa'
      row(0).text_color = 'FFFFFF'
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true

    end
  end

    def event_order_detail_rows
      [['Service Date', 'Start Tme', 'End Time', 'Function', 'Service Location', 'Service Setup Requirements']]+
          @event_order.event_order_details.map do |details|
            [details.service_date, details.service_start_time.strftime('%I:%M %p'), details.service_end_time.strftime('%I:%M %p'), details.function,details.service_location, details.service_setup_requirements]
          end
    end




end