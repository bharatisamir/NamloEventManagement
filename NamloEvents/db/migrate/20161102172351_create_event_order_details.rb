class CreateEventOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :event_order_details do |t|
      t.date :service_date
      t.time :service_start_time
      t.time :service_end_time
      t.string :function
      t.string :service_location
      t.text :service_setup_requirements
      t.references :event_order, foreign_key: true
      t.references :service, foreign_key: true
      t.references :service_provider, foreign_key: true

      t.timestamps
    end
  end
end
