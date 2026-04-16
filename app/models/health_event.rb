class HealthEvent < ApplicationRecord
  include Discard::Model

  belongs_to :child
  belongs_to :health_event_type
  belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by_id'
  validates :date, presence: true
end
