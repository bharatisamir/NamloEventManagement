class Booking < ApplicationRecord

  #belongs_to :service_provider

  #--------------------- FORM VALIDATIONS -------------------------
  validates :booked_date,:event_id,:service_provider_id, presence: true

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------

  belongs_to :event
  belongs_to :event_order
  belongs_to :service_provider
  #has_many :service_providers, dependent: :destroy
  #has_many :services, dependent: :destroy

  #--------------------- End of ASSOCIATIONS -------------------------

  def self.search(search)
    if search
       User.where(( 'email LIKE ?'), "%#{search}%")
    end
  end
end
