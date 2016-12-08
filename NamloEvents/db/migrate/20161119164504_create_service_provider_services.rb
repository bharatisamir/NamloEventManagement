class CreateServiceProviderServices < ActiveRecord::Migration[5.0]
  def change
    create_table :service_provider_services, :id=>false  do |t|
      t.integer :service_provider_id
      t.integer :service_id

    end
  end
end
