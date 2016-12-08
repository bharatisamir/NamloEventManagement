json.extract! offer, :id, :name, :price, :details, :terms_conditions, :expires, :service_provider_id, :created_at, :updated_at
json.url offer_url(offer, format: :json)