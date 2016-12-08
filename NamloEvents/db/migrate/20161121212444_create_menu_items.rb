class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.text :description
      t.integer :quantity
      t.references :menu, foreign_key: true

      t.timestamps
    end
  end
end
