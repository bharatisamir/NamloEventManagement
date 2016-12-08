class AddEventTwoIdToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :event_two_id, :integer
  end
end
