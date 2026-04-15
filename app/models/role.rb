class Role < ApplicationRecord
  has_and_belongs_to_many :user_accounts
  has_and_belongs_to_many :permissions

  validates :code, presence: true
  validates :name, presence: true
end