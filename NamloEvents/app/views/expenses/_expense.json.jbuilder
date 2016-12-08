json.extract! expense, :id, :expense_date, :expense_source, :budgeted_amount, :actual_amount, :notes, :event_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)