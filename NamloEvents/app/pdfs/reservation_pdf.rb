class ReservationPdf < Prawn::Document

  def initialize(event)
    super()
    @event= event
    #@host = Host.find_by_event_id(@event.id)
    #@host_user = User.find(@host.user_id)
    @reservations = Reservation.where(('event_id LIKE ? AND attending_event LIKE ?'), @event.id,true).to_a

    #@total_reserved_guest = GuestList.where(('event_id LIKE ?'), @event.id).count(:total_attendees_expected)

    @total_reserved_guests = 0


    company_logo
    event_title
    event_details
    table_title
    reservations
    total_reserved_guests
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

    bounding_box([350, y_position], :width => 200, :height => 80) do
      text "Host  ID: #{@event.host_id}", size:12, style: :bold, color: 'dd8800'
      text "Host: #{@event.host.user.first_name} #{@event.host.user.last_name}", size:12, style: :bold, color: 'dd8800'
      text "Time: #{@event.event_start_time.strftime('%I:%M %p')} - #{@event.event_end_time.strftime('%I:%M %p')}", size:12, style: :bold, color: 'dd8800'

    end

  end

  def table_title
    text "Complete Reserved Guest List", size:15, style: :bold, color: '0000dd'
  end

  def reservations
    move_down 5
    table(reservation_rows, :column_widths => {0 => 50, 1 => 50, 2 => 100, 3 => 100,5 => 50, 6 => 50, 7 => 70}, :cell_style =>{:size => 8}) do
      cells.borders = []
      row(0).font_style= :bold
      row(0).background_color = '7100aa'
      row(0).text_color = 'FFFFFF'
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true

    end
  end

  def reservation_rows

    [['First Name', 'Last Name', 'Email','Complete Address','Primary Phone', 'Total Attending', 'Need Paper Invitation', 'Notes']]+
        @reservations.map do |reserve|
          @total_reserved_guests= @total_reserved_guests + reserve.total_attending
          [reserve.first_name, reserve.last_name, reserve.email,reserve.complete_address, reserve.primary_phone, reserve.total_attending, reserve.need_paper_invitation.to_s]
        end

  end

  def total_reserved_guests
    move_down 25
    text "Total Reserved Guests: #{@total_reserved_guests}", size:15, style: :bold, color: 'dd8800'

  end



end