class CreatePeerReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :peer_reviews do |t|
      t.string :reviewer_id
      t.integer :organization_score
      t.integer :expertise_score
      t.integer :professionalism_score
      t.integer :time_management_score
      t.integer :cooperation_score
      t.integer :communication_score
      t.integer :people_skills_score
      t.integer :service_score
      t.text :comments
      t.references :serviceprovider, foreign_key: true

      t.timestamps
    end
  end
end
