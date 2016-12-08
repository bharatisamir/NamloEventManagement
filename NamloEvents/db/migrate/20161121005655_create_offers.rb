class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.string :name
      t.float :price
      t.text :details
      t.text :terms_conditions
      t.date :expires
      t.references :service_provider, foreign_key: true

      t.timestamps
    end
  end
end
