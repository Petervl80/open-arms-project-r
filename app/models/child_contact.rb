class ChildContact < ApplicationRecord
  belongs_to :child
  belongs_to :contact
  belongs_to :child_contact_role
  
  belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by'

  validates :child_id, uniqueness: { scope: :contact_id, message: "Este contato já está associado a esta criança" }
end