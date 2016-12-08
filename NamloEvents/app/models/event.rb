class Event < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :event_name,:event_date,:event_start_time,:event_end_time, :event_contact, presence: true


  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :host
  has_one :quotation, dependent: :destroy
  has_one :event_order, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :guest_lists, dependent: :destroy
  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  #--------------------- End of ASSOCIATIONS -------------------------

  geocoded_by :address
  #after_validation :geocode, :if => :address_changed?
  #after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_validation :geocode, if: ->(obj){ obj.address.present? }


=begin
  def self.search(search)
    if search
      find(:all, :conditions => ['email LIKE ?', "%#{search}%"])
    else
      find(:all).order("created_at desc").paginate(page: params[:page], per_page:12)
    end
  end
=end

  def address
    [street_address, city, state_province, country_region ].compact.join(',')
  end

  def address_changed
    [street_address, city, state_province, country_region ].compact.join(',')
  end


end
