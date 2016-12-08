class EventOrder < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :order_date,:primary_onsite_contact,:secondary_onsite_contact,:primary_phone,:secondary_phone,:event_id, presence: true
  validates_length_of :primary_onsite_contact, :maximum => 255
  validates_length_of :secondary_onsite_contact, :maximum => 255

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :event
  has_many :event_order_details, dependent: :destroy

  #--------------------- End of ASSOCIATIONS -------------------------


  def self.search(search)
    if search
      @user = User.where(( 'email LIKE ?'), "%#{search}%")
    end
  end


end
