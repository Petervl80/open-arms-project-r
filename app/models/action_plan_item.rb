class ActionPlanItem < ApplicationRecord
  belongs_to :child
  belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by'

  validates :date, :activity, presence: true
end
