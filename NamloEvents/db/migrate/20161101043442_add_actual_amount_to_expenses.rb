class AddActualAmountToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :actual_amount, :float
  end
end
