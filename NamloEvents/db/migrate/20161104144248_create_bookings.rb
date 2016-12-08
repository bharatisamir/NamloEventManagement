class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.date :booked_date
      t.references :event, foreign_key: true
      t.references :service_provider, foreign_key: true

      t.timestamps
    end
  end
end
