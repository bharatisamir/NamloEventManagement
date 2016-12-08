class MenuPdf < Prawn::Document

  def initialize(menu)

    super()

    @menu= menu
    @event= Event.find(@menu.event_id)

    @total_reserved_entree = 0
    @total_kids_meal = 0

    company_logo
    event_title
    event_details
    table_title
    menu_items
    total_reserved_entree
    total_reserved_kids_meal
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
      text "Menu ID: #{@menu.id}", size:12, style: :bold, color: 'dd8800'
      text "Date: #{@event.event_date.strftime('%A, %B %e, %Y')}", size:12, style: :bold, color: 'dd8800'
    end

    bounding_box([400, y_position], :width => 200, :height => 80) do
      text "Host  ID: #{@event.host_id}", size:12, style: :bold, color: 'dd8800'
      text "Host: #{@event.host.user.first_name} #{@event.host.user.last_name}", size:12, style: :bold, color: 'dd8800'
      text "Time: #{@event.event_start_time.strftime('%I:%M %p')} - #{@event.event_end_time.strftime('%I:%M %p')}", size:12, style: :bold, color: 'dd8800'

    end

  end

  def table_title

    text "Complete Entree Reservation List", size:15, style: :bold, color: '0000dd'
  end

  def menu_items
    move_down 5
    table(menu_items_rows, :column_widths => {0 => 50, 2 => 60}) do
      cells.borders = []
      row(0).font_style = :bold
      row(0).background_color = '7100aa'
      row(0).text_color = 'FFFFFF'
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def menu_items_rows
    [['Item ID', 'Name', 'Quantity',  'Description']]+
        @menu.menu_items.map do |menu|
          @total_reserved_entree = @total_reserved_entree + menu.quantity
          [menu.id, menu.name, menu.quantity,  menu.description]
        end
  end

  def total_reserved_entree
    move_down 35
    text "Total Reserved Entree: #{@total_reserved_entree}", size:15, style: :bold, color: 'dd8800'
  end

  def total_reserved_kids_meal
    move_down 5
    @event.reservations.map do |reserve|
      @total_kids_meal = @total_kids_meal + reserve.kids_meal_required
    end
    text "Total Kids Meal Required: #{@total_kids_meal}", size:15, style: :bold, color: 'dd8800'
  end

end