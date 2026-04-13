class CreateSexTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :sex_types do |t|
      t.string :description, null: false

      t.timestamps
    end
    add_index :sex_types, :description, unique: true
  end
end
