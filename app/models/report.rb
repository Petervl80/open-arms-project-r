class Report < ApplicationRecord
  belongs_to :file_asset, foreign_key: 'file_id'
  belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by_id'

  has_many :report_children, dependent: :destroy
  has_many :children, through: :report_children

  validates :description, :date, presence: true
end
