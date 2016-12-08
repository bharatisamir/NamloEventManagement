class CreatePortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios do |t|
      t.string :tag_line
      t.text :bio
      t.string :website
      t.text :work_experience
      t.text :achievements
      t.text :area_of_expertise
      t.text :services_offered
      t.text :works_projects
      t.references :service_provider, foreign_key: true

      t.timestamps
    end
  end
end
