class CreateProcessTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :process_types do |t|
      t.string :description, null: false

      t.timestamps
    end
    add_index :process_types, :description, unique: true
  end
end
