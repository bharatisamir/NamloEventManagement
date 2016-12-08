class RemoveServiceCategoryFromServiceProviders < ActiveRecord::Migration[5.0]
  def change
    remove_column :service_providers, :service_category, :text
  end
end
