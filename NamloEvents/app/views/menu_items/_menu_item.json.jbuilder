json.extract! menu_item, :id, :name, :description, :quantity, :menu_id, :created_at, :updated_at
json.url menu_item_url(menu_item, format: :json)