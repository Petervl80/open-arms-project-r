class CreateFileTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :file_types do |t|
      t.string :description, null: false

      t.timestamps
    end
    add_index :file_types, :description, unique: true
  end
end
