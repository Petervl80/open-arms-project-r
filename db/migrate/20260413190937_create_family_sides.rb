class CreateFamilySides < ActiveRecord::Migration[8.1]
  def change
    create_table :family_sides do |t|
      t.string :description, null: false

      t.timestamps
    end
    add_index :family_sides, :description, unique: true
  end
end
