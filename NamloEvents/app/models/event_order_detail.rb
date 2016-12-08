class EventOrderDetail < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------
  validates :service_date,:service_start_time,:service_end_time,:function,:service_location,:service_setup_requirements,:event_order_id,:service_id,:service_provider_id, presence: true

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------

  belongs_to :event_order
  has_many :service_providers, dependent: :destroy
  has_many :services, dependent: :destroy

  #--------------------- End of ASSOCIATIONS -------------------------

  def self.search(search)
    if search
      @user = User.where(( 'email LIKE ?'), "%#{search}%")
    end
  end


end
