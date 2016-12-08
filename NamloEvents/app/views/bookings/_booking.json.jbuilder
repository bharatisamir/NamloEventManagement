json.extract! booking, :id, :booked_date, :event_id, :service_provider_id, :created_at, :updated_at
json.url booking_url(booking, format: :json)