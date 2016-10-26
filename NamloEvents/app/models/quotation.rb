class Quotation < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :rfq_issue_date,:rfq_closing_date,:rfq_contact,:rfq_delivery_method, :services_requested, :comments, :event_id, presence: true


  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :event


  #--------------------- End of ASSOCIATIONS -------------------------
end
