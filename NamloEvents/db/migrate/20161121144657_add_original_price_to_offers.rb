class AddOriginalPriceToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :original_price, :float
  end
end
