class AddGroomTagline2ToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :groom_tagline2, :string
  end
end
