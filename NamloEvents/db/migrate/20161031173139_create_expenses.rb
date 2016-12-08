class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.date :expense_date
      t.string :expense_source
      t.integer :budgeted_amount
      t.integer :actual_amount
      t.text :notes
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
