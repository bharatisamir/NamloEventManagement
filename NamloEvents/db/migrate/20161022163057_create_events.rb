class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :event_name
      t.date :event_date
      t.time :event_start_time
      t.time :event_end_time
      t.string :street_address
      t.string :city
      t.string :state_province
      t.string :zip_postal_code
      t.string :country_region
      t.string :event_contact
      t.text :comments
      t.boolean :publish_on_marketplace
      t.references :host, foreign_key: true

      t.timestamps
    end
  end
end
