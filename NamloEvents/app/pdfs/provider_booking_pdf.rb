class ProviderBookingPdf < Prawn::Document

  def initialize(status)

    super()

    @status = status
    @booking = @status.split(',')

    if @booking[1]=='service_provider_id'
      @bookings = Booking.where(( 'service_provider_id LIKE ?'),@booking[0].to_i).to_a
      @service_provider = ServiceProvider.find(@booking[0].to_i)
      #@provider_user = User.find(@service_provider.user_id)
      @provider_profile = Profile.find_by_user_id(@service_provider.user_id)
    end

    company_logo
    event_title
    event_details
    table_title
    bookings

  end

  def company_logo
    @path = Rails.root + 'app/assets/images/namlo_pdf.jpg'
    image "#{@path}", :height => 89, :width => 200
  end


  def event_title
    #move_down 10
    text "#{@service_provider.user.first_name} #{@service_provider.user.last_name }", size:25, style: :bold, :align => :center, color: '0000dd'
  end

  def event_details
    move_down 40
    y_position = cursor
    bounding_box([1, y_position], :width => 250, :height => 80) do
      text "Service Provider ID: #{@service_provider.id}", size:12, style: :bold, color: 'dd8800'
      text "Business Phone: #{@service_provider.business_phone}", size:12, style: :bold, color: 'dd8800'
      text "Company: #{@service_provider.company}", size:12, style: :bold, color: 'dd8800'
    end

    bounding_box([400, y_position], :width => 200, :height => 80) do
      text "User ID: #{@service_provider.user.id}", size:12, style: :bold, color: 'dd8800'
      text "Home Phone: #{@provider_profile.home_phone}", size:12, style: :bold, color: 'dd8800'
      text "Cell Phone: #{@provider_profile.cell_phone}", size:12, style: :bold, color: 'dd8800'
      #text "Company: #{@service_provider.company}", size:12, style: :bold, color: 'dd8800'
    end

  end

  def table_title
    text "Complete Booking List", size:15, style: :bold, color: '0000dd'
  end

  def bookings
    if @booking[1]=='service_provider_id'
      move_down 5
      table(booking_rows, :column_widths => {0 => 50, 1 => 50, 2 => 40, 3 => 80, 4 => 80, 5 => 50, 6 => 80, 7 => 50},:cell_style =>{:size => 8}) do
        cells.borders = []
        row(0).font_style = :bold
        row(0).background_color = '7100aa'
        row(0).text_color = 'FFFFFF'
        self.row_colors = ['DDDDDD', 'FFFFFF']
        self.header = true
      end
    end

  end

  def booking_rows
    [['Booked Date','Event Date','Event ID','Event Name','Host Name','Time','Venue','Discount ID','Promo Name']]+
        @bookings.map do |book|
          @host = Host.find(book.event.host_id)
          @host_user = User.find(@host.user_id)
          @host_name = @host_user.first_name + " "+ @host_user.last_name
          @event = Event.find(book.event_id)
          @event_time = book.event.event_start_time.strftime('%I:%M %p') +' -'+  book.event.event_end_time.strftime('%I:%M %p')
          @offer_name = ''

          if book.offer_id != nil
            @offer = Offer.find(book.offer_id)
            if @offer != nil
              @offer_name = @offer.name
            end
          end

          [book.booked_date, @event.event_date, book.event_id,@event.event_name, @host_name, @event_time, @event.venue, book.offer_id, @offer_name]
          #[book.booked_date, @event.event_date, book.event_id,@event.event_name, @host_name, @event_time, @event.venue, book.offer_id, @offer_name]
        end

  end

end