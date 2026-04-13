class CreateChildren < ActiveRecord::Migration[8.1]
  def change
    create_table :children do |t|
      t.string :full_name, null: false
      t.string :process_number
      t.date :birth_date
      t.string :nationality
      t.string :naturalness
      t.string :cpf
      t.string :rg
      t.text :observations

      # Relacionamentos (foreign keys)
      t.references :sex_type, null: true, foreign_key: true
      t.references :race_type, null: true, foreign_key: true
      t.references :blood_type, null: true, foreign_key: true

      t.timestamps
    end

    # Índices para pesquisa rápida e garantia de unicidade
    add_index :children, :cpf, unique: true
    add_index :children, :process_number, unique: true
    add_index :children, :full_name
  end
end