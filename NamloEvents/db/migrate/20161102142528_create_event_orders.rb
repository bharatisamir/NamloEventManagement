class CreateEventOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :event_orders do |t|
      t.date :order_date
      t.string :primary_onsite_contact
      t.string :secondary_onsite_contact
      t.string :primary_phone
      t.string :secondary_phone
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
