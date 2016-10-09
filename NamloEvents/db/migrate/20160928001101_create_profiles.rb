class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :street_address
      t.string :city
      t.string :state_province
      t.string :zip_postal_code
      t.string :country_region
      t.string :home_phone
      t.string :cell_phone
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
