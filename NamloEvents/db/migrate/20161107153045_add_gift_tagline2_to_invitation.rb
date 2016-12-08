class AddGiftTagline2ToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :gift_tagline2, :string
  end
end
