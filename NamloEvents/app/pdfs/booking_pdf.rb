class BookingPdf < Prawn::Document

  def initialize(status)

    super()
    @status = status
    @booking = @status.split(',')

    if @booking[1]=='event_id'
      @bookings = Booking.where(( 'event_id LIKE ?'),@booking[0].to_i).to_a
      @event = Event.find(@booking[0].to_i)
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
    text "#{@event.event_name}", size:25, style: :bold, :align => :center, color: '0000dd'
  end

  def event_details
      move_down 40
      y_position = cursor
      bounding_box([1, y_position], :width => 250, :height => 80) do
        text "Event ID: #{@event.id}", size:12, style: :bold, color: 'dd8800'
        text "Venue: #{@event.venue}", size:12, style: :bold, color: 'dd8800'
        text "Date: #{@event.event_date.strftime('%A, %B %e, %Y')}", size:12, style: :bold, color: 'dd8800'
      end

      bounding_box([400, y_position], :width => 200, :height => 80) do
        text "Host  ID: #{@event.host_id}", size:12, style: :bold, color: 'dd8800'
        text "Host: #{@event.host.user.first_name} #{@event.host.user.last_name}", size:12, style: :bold, color: 'dd8800'
        text "Time: #{@event.event_start_time.strftime('%I:%M %p')} - #{@event.event_end_time.strftime('%I:%M %p')}", size:12, style: :bold, color: 'dd8800'

      end
  end

  def table_title

    text "Complete Booking List", size:15, style: :bold, color: '0000dd'
  end

  def bookings
      move_down 5
      table(booking_rows, :column_widths => {0 => 80, 1 => 50, 4 => 70}) do
        cells.borders = []
        row(0).font_style = :bold
        row(0).background_color = '7100aa'
        row(0).text_color = 'FFFFFF'
        self.row_colors = ['DDDDDD', 'FFFFFF']
        self.header = true
      end
  end

  def booking_rows

      [['Booked Date', 'Vendor ID', 'Vendor First Name', 'Vendor Last Name','Discount ID', 'Promo Name']]+
          @bookings.map do |book|
            @provider_user = User.find(ServiceProvider.find(book.service_provider_id).user_id)

            @offer_name = ''

            if book.offer_id != nil
              @offer = Offer.find(book.offer_id)
              if @offer != nil
                @offer_name = @offer.name
              end
            end

            [book.booked_date, book.service_provider_id, @provider_user.first_name, @provider_user.last_name , book.offer_id, @offer_name]
          end

  end



end