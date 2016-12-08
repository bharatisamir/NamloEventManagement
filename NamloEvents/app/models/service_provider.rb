class ServiceProvider < ApplicationRecord


  attr_accessor :service_id

  #--------------------- FORM VALIDATIONS -------------------------

  validates :company,:business_phone,:fax,:user_id, presence: true
  validates :user_id, uniqueness: true


  validates_length_of :company, :maximum => 50
  validates_length_of :business_phone, :minimum => 10
  validates_length_of :fax, :minimum => 10
  validates_length_of :business_phone, :maximum => 20
  validates_length_of :fax, :maximum => 20

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :user
  belongs_to :event_order_detail
  has_one :portfolio, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :services, :through => :service_provider_services, dependent: :destroy
  has_many :services, dependent: :destroy

  #--------------------- End of ASSOCIATIONS -------------------------

end
