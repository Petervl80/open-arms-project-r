class CreateFileAssets < ActiveRecord::Migration[8.1]
  def change
    create_table :file_assets do |t|
      t.string :file_name, null: false
      t.string :content_type, null: false
      t.integer :size, null: false, limit: 8
      t.string :storage_path, null: false
      t.references :file_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end