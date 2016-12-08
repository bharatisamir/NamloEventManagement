class Invitation < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------
  validates :event_id, presence: true

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :event
  has_attached_file :image, styles: { large: "800x400>", medium: "300x300>", thumb: "200x200>" }, default_url: "/assets/invitation/invitation_head_default.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


  #--------------------- End of ASSOCIATIONS -------------------------

  def self.search(search)
    if search
      @user = User.where(( 'email LIKE ?'), "%#{search}%")
    end
  end


end
