class CreateToDoItems < ActiveRecord::Migration[5.0]
  def change
    create_table :to_do_items do |t|
      t.string :todo_item
      t.datetime :completed_at
      t.references :to_do_list, foreign_key: true

      t.timestamps
    end
  end
end
