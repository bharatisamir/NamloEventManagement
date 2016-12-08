class Gallery < ApplicationRecord

  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :portfolio
  has_many :pictures, dependent: :destroy

  #--------------------- End of ASSOCIATIONS -------------------------


  #--------------------- FORM VALIDATIONS -------------------------
  validates :name, :description, :portfolio_id, presence: true

  validates_length_of :name, :maximum => 100
  validates_length_of :description, :maximum => 500

  #--------------------- End of VALIDATIONS -------------------------


end
