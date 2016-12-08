class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.string :opening_tag_line
      t.string :groom_tag_line
      t.string :mid_tag_line
      t.string :bride_tag_line
      t.string :event_tag_line
      t.string :gift_tag_line
      t.string :closing_tag_line
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
