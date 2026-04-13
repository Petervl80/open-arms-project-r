class IndividualCare < ApplicationRecord
  belongs_to :child
  belongs_to :individual_care_type
  belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by'

  validates :date, presence: true
end
