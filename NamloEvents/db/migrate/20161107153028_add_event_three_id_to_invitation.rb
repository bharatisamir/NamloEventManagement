class AddEventThreeIdToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :event_three_id, :integer
  end
end
