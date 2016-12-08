class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :complete_address
      t.string :primary_phone
      t.boolean :attending_event
      t.integer :total_attending
      t.string :food_choice
      t.integer :kids_meal_required
      t.string :need_paper_invitation
      t.string :boolean
      t.boolean :food_allergies
      t.text :special_notes
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
