class CreateFileAssets < ActiveRecord::Migration[8.1]
  def change
    create_table :file_assets do |t|
      t.string :original_file_name, null: false
      t.string :mime_type, null: false
      t.integer :size_bytes, null: false, limit: 8
      t.string :storage_path_or_url, null: false
      t.references :file_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end