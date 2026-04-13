class SchoolProgress < ApplicationRecord
  belongs_to :child
  belongs_to :school_event_type
  belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by'
  validates :date, presence: true
end
