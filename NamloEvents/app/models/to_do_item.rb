class ToDoItem < ApplicationRecord

  #--------------------- FORM VALIDATIONS -------------------------

  validates :todo_item,:to_do_list_id, presence: true

  validates_length_of :todo_item, :maximum => 255

  #--------------------- End of VALIDATIONS -------------------------


  #--------------------- ASSOCIATIONS -------------------------
  belongs_to :to_do_list

  #--------------------- End of ASSOCIATIONS -------------------------

  def completed?
    !completed_at.blank?
  end
end
