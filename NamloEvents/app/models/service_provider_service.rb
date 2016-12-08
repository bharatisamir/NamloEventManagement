class ServiceProviderService < ApplicationRecord
  #--------------------- FORM VALIDATIONS -------------------------


  #--------------------- End of VALIDATIONS -------------------------

  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :service_provider
  belongs_to :service


  #--------------------- End of ASSOCIATIONS -------------------------
end
