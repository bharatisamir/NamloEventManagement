class Host < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :user_id, presence: true
  validates :user_id, uniqueness: true

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :user
  has_many :events, dependent: :destroy

  #--------------------- End of ASSOCIATIONS -------------------------

end
