class AddBudgetedAmountToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :budgeted_amount, :float
  end
end
