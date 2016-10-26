class ToDoList < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :todo_list_title,:todo_list_description,:user_id, presence: true

  validates_length_of :todo_list_title, :maximum => 100
  validates_length_of :todo_list_description, :maximum => 255

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :user
  has_many :to_do_items, dependent: :destroy

  #--------------------- End of ASSOCIATIONS -------------------------

end
