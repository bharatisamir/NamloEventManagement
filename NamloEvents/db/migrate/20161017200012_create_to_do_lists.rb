class CreateToDoLists < ActiveRecord::Migration[5.0]
  def change
    create_table :to_do_lists do |t|
      t.string :todo_list_title
      t.text :todo_list_description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
