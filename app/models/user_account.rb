class UserAccount < ApplicationRecord
  include Discard::Model

  has_secure_password # Isso gerencia a criptografia da senha automaticamente
  has_and_belongs_to_many :roles
  
  validates :email, presence: true, uniqueness: true

  def admin?
    roles.exists?(code: 'ADMIN')
  end

  def technical_team?
    roles.exists?(code: 'TECHNICAL_TEAM')
  end

  def privileged?
    admin? || technical_team?
  end

  def has_permission?(permission_code)
    return true if admin? 
    
    roles.joins(:permissions).where(permissions: { code: permission_code }).exists?
  end
end