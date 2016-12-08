class RemoveActualAmountFromExpenses < ActiveRecord::Migration[5.0]
  def change
    remove_column :expenses, :actual_amount, :integer
  end
end
