json.extract! to_do_item, :id, :todo_item, :completed_at, :to_do_list_id, :created_at, :updated_at
json.url to_do_item_url(to_do_item, format: :json)