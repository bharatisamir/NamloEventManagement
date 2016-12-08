class CreateIncomes < ActiveRecord::Migration[5.0]
  def change
    create_table :incomes do |t|
      t.date :income_date
      t.string :income_source
      t.float :expected_amount
      t.float :actual_amount
      t.text :notes
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
