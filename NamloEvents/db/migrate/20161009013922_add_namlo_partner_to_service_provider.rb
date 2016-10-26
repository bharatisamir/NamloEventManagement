class AddNamloPartnerToServiceProvider < ActiveRecord::Migration[5.0]
  def change
    add_column :service_providers, :namlo_partner, :boolean
  end
end
