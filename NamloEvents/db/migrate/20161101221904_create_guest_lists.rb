class CreateGuestLists < ActiveRecord::Migration[5.0]
  def change
    create_table :guest_lists do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :total_attendees_expected
      t.string :seating_arrangement
      t.text :notes
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
