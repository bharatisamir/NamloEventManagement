class CreateGalleries < ActiveRecord::Migration[5.0]
  def change
    create_table :galleries do |t|
      t.string :name
      t.text :description
      t.references :portfolio, foreign_key: true

      t.timestamps
    end
  end
end
