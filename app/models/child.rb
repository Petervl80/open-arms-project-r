class Child < ApplicationRecord
  # Relacionamentos
  belongs_to :sex_type, optional: true
  belongs_to :race_type, optional: true
  belongs_to :blood_type, optional: true

  validates :full_name, presence: true
  
  validate :birth_date_cannot_be_in_the_future

  validates :cpf, uniqueness: { allow_blank: true }, 
                  format: { with: /\A\d{11}\z/, message: "deve conter 11 dígitos", allow_blank: true }

  private

  def birth_date_cannot_be_in_the_future
    if birth_date.present? && birth_date > Date.today
      errors.add(:birth_date, "não pode ser uma data futura")
    end
  end
end
end
