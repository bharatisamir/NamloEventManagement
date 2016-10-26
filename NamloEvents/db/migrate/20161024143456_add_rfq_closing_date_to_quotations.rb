class AddRfqClosingDateToQuotations < ActiveRecord::Migration[5.0]
  def change
    add_column :quotations, :rfq_closing_date, :date
  end
end
