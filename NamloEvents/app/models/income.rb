class Income < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :income_date,:income_source,:expected_amount,:actual_amount, :notes, :event_id, presence: true

  validates_length_of :notes, :maximum => 500
  validates_length_of :income_source, :maximum => 255

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :event

  #--------------------- End of ASSOCIATIONS -------------------------


  def self.search(search)
    if search
      User.where(( 'email LIKE ?'), "%#{search}%")
    end
  end

end
