class CreateQuotations < ActiveRecord::Migration[5.0]
  def change
    create_table :quotations do |t|
      t.date :rfq_issue_date
      t.date :rfq_closing_date
      t.string :rfq_contact
      t.string :frq_delivery_method
      t.text :services_requested
      t.text :comments
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
