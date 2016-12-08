class AddBrideTagline2ToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :bride_tagline2, :string
  end
end
