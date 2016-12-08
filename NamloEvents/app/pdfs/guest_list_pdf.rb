class GuestListPdf < Prawn::Document

  def initialize(event)
    super()
    @event= event
    #@host = Host.find_by_event_id(@event.id)
    #@host_user = User.find(@host.user_id)


    #@total_guest = GuestList.where(('event_id LIKE ?'), @event.id).count(:total_attendees_expected)
    @total_guest = 0

    company_logo
    report_title
    event_details
    table_title
    guest_lists
    total_attendants
  end

  def company_logo

    @path = Rails.root + 'app/assets/images/namlo_pdf.jpg'

    image "#{@path}", :height => 89, :width => 200
  end



  def report_title
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

    text "Complete Guest List", size:15, style: :bold, color: '0000dd'
  end

  def guest_lists
    move_down 5
    table(guest_list_rows, :column_widths => {0 => 100, 1 => 100, 3 => 70}) do
      cells.borders = []
      row(0).font_style = :bold
      row(0).background_color = '7100aa'
      row(0).text_color = 'FFFFFF'
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true

    end
  end

  def guest_list_rows
    [['First Name', 'Last Name', 'Email', 'Total Expected', 'Seating', 'Notes']]+
        @event.guest_lists.map do |list|
          @total_guest= @total_guest + list.total_attendees_expected
          [list.first_name, list.last_name, list.email, list.total_attendees_expected, list.seating_arrangement, list.notes]
        end
  end

  def total_attendants
    move_down 25
    text "Total Attendants Expected: #{@total_guest}", size:15, style: :bold, color: 'dd8800'

  end
end