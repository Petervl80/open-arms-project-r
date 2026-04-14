class SocialActivity < ApplicationRecord
  belongs_to :child
  belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by_id'
  validates :date, presence: true
end
