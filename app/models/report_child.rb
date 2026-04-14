class ReportChild < ApplicationRecord
  belongs_to :report
  belongs_to :child
  belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by'
end
