class AddOfferIdToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :offer_id, :integer
  end
end
