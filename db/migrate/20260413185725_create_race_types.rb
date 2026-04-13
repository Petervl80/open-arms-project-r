class CreateRaceTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :race_types do |t|
      t.string :description, null: false

      t.timestamps
    end
    add_index :race_types, :description, unique: true
  end
end
