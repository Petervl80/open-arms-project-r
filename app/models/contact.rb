class Contact < ApplicationRecord
    belongs_to :family_side, optional: true
    
    belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by_id'

    has_many :child_contacts, dependent: :destroy
    has_many :children, through: :child_contacts

    validates :full_name, presence: true, length: { maximum: 50 }
end
