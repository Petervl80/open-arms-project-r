class CreateChildren < ActiveRecord::Migration[8.1]
  def change
    create_table :children do |t|
      # Dados Pessoais
      t.string :process_number, limit: 39
      t.string :full_name, limit: 70, null: false
      t.date :birth_date
      t.references :sex_type, null: true, foreign_key: true
      t.string :nationality, limit: 25
      t.string :place_of_birth, limit: 25
      t.references :race_type, null: true, foreign_key: true
      t.string :disability_notes, limit: 25
      
      # Ficheiro de Foto (Ligação a file_assets)
      t.references :photo_file, null: true, foreign_key: { to_table: :file_assets }

      # Documentação
      t.string :birth_certificate_number, limit: 100
      t.string :registry_office, limit: 50
      t.string :cpf, limit: 14
      t.string :rg, limit: 12

      # Processo de Admissão / Judicial
      t.string :referred_by, limit: 50
      t.string :admission_reason, limit: 50
      t.string :responsible_court, limit: 50
      t.references :process_type, null: true, foreign_key: true
      t.string :admission_guide_number, limit: 25
      t.date :admission_guide_date
      
      # Processo de Alta
      t.date :discharge_date
      t.string :discharge_reason, limit: 50

      # Contexto Social e Familiar
      t.text :shelter_conditions
      t.text :family_aspects
      t.text :family_commitments

      # Escolaridade
      t.string :school_name, limit: 50
      t.integer :school_year

      # Saúde
      t.string :sus_card_number, limit: 25
      t.text :controlled_medication_notes
      t.references :blood_type, null: true, foreign_key: true
      t.boolean :health_hiv, default: false
      t.boolean :health_hep_b, default: false
      t.boolean :health_hep_c, default: false
      t.boolean :health_syphilis, default: false
      t.text :medical_report_text
      
      # Ficheiro de Relatório Médico (Ligação a file_assets)
      t.references :medical_report_file, null: true, foreign_key: { to_table: :file_assets }

      # Auditoria
      t.references :updated_by, null: false, foreign_key: { to_table: :user_accounts }

      t.timestamps
    end

    add_index :children, :cpf, unique: true
    add_index :children, :process_number
  end
end