class RemoveBudgetedAmountFromExpenses < ActiveRecord::Migration[5.0]
  def change
    remove_column :expenses, :budgeted_amount, :integer
  end
end
