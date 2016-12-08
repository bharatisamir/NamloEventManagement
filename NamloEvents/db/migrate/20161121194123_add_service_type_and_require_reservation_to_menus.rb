class AddServiceTypeAndRequireReservationToMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :service_type, :string
    add_column :menus, :require_reservation, :boolean
  end
end
