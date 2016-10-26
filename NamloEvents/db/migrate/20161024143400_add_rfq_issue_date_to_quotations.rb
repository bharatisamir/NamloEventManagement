class AddRfqIssueDateToQuotations < ActiveRecord::Migration[5.0]
  def change
    add_column :quotations, :rfq_issue_date, :date
  end
end
