class RemoveRfqIssueDateFromQuotations < ActiveRecord::Migration[5.0]
  def change
    remove_column :quotations, :rfq_issue_date, :date
  end
end
