class Alarm < ApplicationRecord
  belongs_to :child
  belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by'
  validates :date, :description, presence: true
end
