json.extract! income, :id, :income_date, :income_source, :expected_amount, :actual_amount, :notes, :event_id, :created_at, :updated_at
json.url income_url(income, format: :json)