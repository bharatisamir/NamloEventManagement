json.extract! to_do_list, :id, :todo_list_title, :todo_list_description, :user_id, :created_at, :updated_at
json.url to_do_list_url(to_do_list, format: :json)