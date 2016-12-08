class Expense < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :expense_date,:expense_source,:budgeted_amount,:actual_amount, :notes, :event_id, presence: true

  validates_length_of :notes, :maximum => 500
  validates_length_of :expense_source, :maximum => 255

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :event

  #--------------------- End of ASSOCIATIONS -------------------------


  def self.search(search)
    if search
      @user = User.where(( 'email LIKE ?'), "%#{search}%")
    end
  end

end
