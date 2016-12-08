class AddEventManagerToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :event_manager, :integer
  end
end
