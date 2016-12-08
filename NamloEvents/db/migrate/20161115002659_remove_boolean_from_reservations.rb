class RemoveBooleanFromReservations < ActiveRecord::Migration[5.0]
  def change
    remove_column :reservations, :boolean, :text
  end
end
