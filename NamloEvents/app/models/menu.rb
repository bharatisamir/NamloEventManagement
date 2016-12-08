class Menu < ApplicationRecord

  SERVICE_TYPE = %w[Buffet Served ]


  #--------------------- FORM VALIDATIONS -------------------------
  validates :name, :service_type, :event_id,  presence: true

  validates_length_of :name, :maximum => 255


  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :event
  has_many :menu_items, dependent: :destroy



  #--------------------- End of ASSOCIATIONS -------------------------

  def self.search(search)
    if search
      @user = User.where(( 'email LIKE ?'), "%#{search}%")
    end
  end

end
