class UserAccount < ApplicationRecord
  has_secure_password # Isso gerencia a criptografia da senha automaticamente
  has_and_belongs_to_many :roles
  
  validates :email, presence: true, uniqueness: true
end