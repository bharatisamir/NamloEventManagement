class Role < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------



  #--------------------- End of VALIDATIONS -------------------------

  #--------------------- ASSOCIATIONS -------------------------
  has_and_belongs_to_many :users, dependent: :destroy

  #--------------------- End of ASSOCIATIONS -------------------------

end
