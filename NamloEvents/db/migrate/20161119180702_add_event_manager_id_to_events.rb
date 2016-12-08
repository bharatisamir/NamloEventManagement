class AddEventManagerIdToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :event_manager_id, :integer
  end
end
