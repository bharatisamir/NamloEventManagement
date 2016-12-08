class MenuItem < ApplicationRecord


  #--------------------- FORM VALIDATIONS -------------------------
  validates :name, :description, :menu_id,  presence: true

  validates_length_of :name, :maximum => 255
  validates_length_of :description, :maximum => 500

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :menu

  #--------------------- End of ASSOCIATIONS -------------------------


end
