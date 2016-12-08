class Portfolio < ApplicationRecord

  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :service_provider
  has_many   :galleries, dependent: :destroy

  #--------------------- End of ASSOCIATIONS -------------------------

  #--------------------- FORM VALIDATIONS -------------------------

  validates :tag_line, :bio, :website, :work_experience, :achievements, :area_of_expertise, :services_offered, :works_projects, :service_provider_id, presence: true

  validates_length_of :tag_line, :maximum => 500
  validates_length_of :bio, :maximum => 1000
  validates_length_of :website, :maximum => 500
  validates_length_of :work_experience, :maximum => 1000
  validates_length_of :achievements, :maximum => 1000
  validates_length_of :area_of_expertise, :maximum => 1000
  validates_length_of :services_offered, :maximum => 1000
  validates_length_of :works_projects, :maximum => 1000

  #--------------------- End of VALIDATIONS -------------------------
end
