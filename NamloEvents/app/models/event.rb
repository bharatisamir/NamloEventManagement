class Event < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :event_name,:event_date,:event_start_time,:event_end_time, :publish_on_marketplace, :event_contact, presence: true


  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :host
  has_one :quotation, dependent: :destroy
  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  #--------------------- End of ASSOCIATIONS -------------------------
end
