class CreateBloodTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :blood_types do |t|
      t.string :description, null: false

      t.timestamps
    end
    add_index :blood_types, :description, unique: true
  end
end
