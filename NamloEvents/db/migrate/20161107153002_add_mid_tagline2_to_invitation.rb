class AddMidTagline2ToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :mid_tagline2, :string
  end
end
