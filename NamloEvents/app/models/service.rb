class Service < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------
  validates :service_name,:service_description, presence: true

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
    belongs_to :event_order_detail
    has_many :service_providers, :through => :service_provider_services, dependent: :destroy
    has_many :service_providers, dependent: :destroy
  #--------------------- End of ASSOCIATIONS -------------------------

end
