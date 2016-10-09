class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :reviewer_id
      t.integer :rating_score
      t.text :comments
      t.references :serviceprovider, foreign_key: true

      t.timestamps
    end
  end
end
