class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :service_name
      t.text :service_description

      t.timestamps
    end
  end
end
