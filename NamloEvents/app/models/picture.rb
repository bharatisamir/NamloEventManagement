class Picture < ApplicationRecord

  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :gallery
  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: "/assets/missing.png"
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  do_not_validate_attachment_file_type :image

  #--------------------- End of ASSOCIATIONS -------------------------

  #--------------------- FORM VALIDATIONS -------------------------


  #--------------------- End of VALIDATIONS -------------------------
end
