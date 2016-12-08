class RemoveEventManagerFromEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :event_manager, :integer
  end
end
