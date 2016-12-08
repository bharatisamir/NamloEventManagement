class AddNeedPaperInvitationToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :need_paper_invitation, :boolean
  end
end
