class RevenueReportPdf < Prawn::Document

  def initialize(event, view)
    super()
    @event= event
    @view = view
    #@host = Host.find_by_event_id(@event.id)
    #@host_user = User.find(@host.user_id)

    #@total_expense = GuestList.where(('event_id LIKE ?'), @event.id).count(:total_attendees_expected)
    @total_revenues= 0

    @host_profile = Profile.find(@event.host.user.id)
    @provider_user = User.find(ServiceProvider.find(@event.event_manager_id).user_id)

    company_logo
    event_title
    event_sub_title
    event_sub_title1
    report_title
    event_details
    table_title
    incomes
    total_revenues

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
    move_down 20
    text "Revenue Report", size:25, style: :bold, :align => :center, color: '0000dd'
  end

  def event_sub_title
    move_down 1
    text "Client Phone: #{@host_profile.cell_phone}", size:7, style: :bold, :align => :center,color: 'dd8800'
  end

  def event_sub_title1
    move_down 1
    text "Address: #{@host_profile.street_address}, #{@host_profile.city},  #{@host_profile.state_province} #{@host_profile.zip_postal_code}", size:7, style: :bold,:align => :center, color: 'dd8800'
  end


  def event_details

    move_down 40
    y_position = cursor
    bounding_box([1, y_position], :width => 250, :height => 80) do
      text "Provider ID: #{@event.event_manager_id}", size:12, style: :bold, color: 'dd8800'
      text "Name: #{@provider_user.first_name} #{@provider_user.last_name}", size:12, style: :bold, color: 'dd8800'
      text "Designation: Event Manager", size:12, style: :bold, color: 'dd8800'
      #text "Report From: #{@event.incomes.first.income_date} #{'   '} To: #{@event.incomes.last.income_date}", size:12, style: :bold, color: 'dd8800'

    end

    bounding_box([415, y_position], :width => 200, :height => 80) do
      text "Event ID: #{@event.id}", size:12, style: :bold, color: 'dd8800'
      text "Client  ID: #{@event.host_id}", size:12, style: :bold, color: 'dd8800'
      text "Name: #{@event.host.user.first_name} #{@event.host.user.last_name}", size:12, style: :bold, color: 'dd8800'
      text "Report#: 1", size:12, style: :bold, color: 'dd8800'
    end
  end


  def table_title
    text "Complete List of Revenues", size:15, style: :bold, color: '0000dd'
  end

  def incomes
    move_down 5
    table(income_rows, :column_widths => {0 => 80, 2 => 70, 3 => 70}) do
      cells.borders = []
      row(0).font_style = :bold
      row(0).background_color = '7100aa'
      row(0).text_color = 'FFFFFF'
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true

    end
  end

  def income_rows
    [['Date', 'Revenue Source', 'Expected Amount', 'Actual Amount', 'Notes']]+
        @event.incomes.map do |revenue|
          @total_revenues = @total_revenues + revenue.actual_amount
          [revenue.income_date, revenue.income_source, price(revenue.expected_amount), price(revenue.actual_amount), revenue.notes]
        end
  end

  def total_revenues
    move_down 25
    text "Total Revenues: #{price(@total_revenues)}", size:15, style: :bold, color: 'dd8800'
  end

  def price(num)
    @view.number_to_currency(num)
  end

end
