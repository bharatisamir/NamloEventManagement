class CreateServiceProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :service_providers do |t|
      t.string :service_category
      t.string :company
      t.string :business_phone
      t.string :fax
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
