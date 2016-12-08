json.extract! service, :id, :service_name, :service_description, :created_at, :updated_at
json.url service_url(service, format: :json)