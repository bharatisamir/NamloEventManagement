class AddGiftTagline3ToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :gift_tagline3, :string
  end
end
