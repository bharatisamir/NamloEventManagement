class RemoveNeedPaperInvitationFromReservations < ActiveRecord::Migration[5.0]
  def change
    remove_column :reservations, :need_paper_invitation, :string
  end
end
