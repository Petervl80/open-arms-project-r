require "cpf_cnpj"

class Child < ApplicationRecord
  include Discard::Model

  # Relacionamentos com Tabelas de Domínio
  belongs_to :sex_type, optional: true
  belongs_to :race_type, optional: true
  belongs_to :blood_type, optional: true
  belongs_to :process_type, optional: true

  # Relacionamentos com Ficheiros (FileAsset)
  belongs_to :photo_file, class_name: 'FileAsset', optional: true
  belongs_to :medical_report_file, class_name: 'FileAsset', optional: true

  # Relacionamento de Auditoria
  belongs_to :updater, class_name: 'UserAccount', foreign_key: 'updated_by_id'

  # Relacionamento com Contatos
  has_many :child_contacts, dependent: :destroy
  has_many :contacts, through: :child_contacts
  accepts_nested_attributes_for :child_contacts, allow_destroy: true

  has_many :action_plan_items, dependent: :destroy
  has_many :family_events, dependent: :destroy
  has_many :individual_cares, dependent: :destroy

  has_many :school_progresses, dependent: :destroy
  has_many :health_events, dependent: :destroy
  has_many :social_development_entries, dependent: :destroy
  has_many :social_activities, dependent: :destroy

  has_many :alarms, dependent: :destroy
  has_many :report_children, dependent: :destroy
  has_many :reports, through: :report_children

  # Validações Básicas
  validates :full_name, presence: true, length: { maximum: 70 }
  validate :cpf_must_be_valid
  
  validate :birth_date_cannot_be_in_the_future

  private

  def birth_date_cannot_be_in_the_future
    if birth_date.present? && birth_date > Date.today
      errors.add(:birth_date, "não pode ser uma data futura")
    end
  end

  def cpf_must_be_valid
    if cpf.present? && !CPF.valid?(cpf)
      errors.add(:cpf, "não é um CPF válido")
    end
  end
end