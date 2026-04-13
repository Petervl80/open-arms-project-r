class Child < ApplicationRecord
  # Relacionamentos com Tabelas de Domínio
  belongs_to :sex_type, optional: true
  belongs_to :race_type, optional: true
  belongs_to :blood_type, optional: true
  belongs_to :process_type, optional: true

  # Relacionamentos com Ficheiros (FileAsset)
  belongs_to :photo_file, class_name: 'FileAsset', optional: true
  belongs_to :medical_report_file, class_name: 'FileAsset', optional: true

  # Relacionamento de Auditoria
  belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by'

  # Relacionamento com Contacos
  has_many :child_contacts, dependent: :destroy
  has_many :contacts, through: :child_contacts
  accepts_nested_attributes_for :child_contacts, allow_destroy: true

  # Validações Básicas
  validates :full_name, presence: true, length: { maximum: 70 }
  validates :cpf, uniqueness: { allow_blank: true }, 
                  format: { with: /\A\d{11}\z/, message: "deve conter 11 dígitos", allow_blank: true }
  
  validate :birth_date_cannot_be_in_the_future

  private

  def birth_date_cannot_be_in_the_future
    if birth_date.present? && birth_date > Date.today
      errors.add(:birth_date, "não pode ser uma data futura")
    end
  end
end