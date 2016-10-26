class RemoveRfqClosingDateFromQuotations < ActiveRecord::Migration[5.0]
  def change
    remove_column :quotations, :rfq_closing_date, :date
  end
end
