class AddNamloPreferredToServiceProvider < ActiveRecord::Migration[5.0]
  def change
    add_column :service_providers, :namlo_preferred, :boolean
  end
end
