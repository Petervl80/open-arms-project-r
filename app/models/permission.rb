class Permission < ApplicationRecord
    validates :code, presence: true
end
