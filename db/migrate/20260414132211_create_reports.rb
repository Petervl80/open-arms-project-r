class CreateReports < ActiveRecord::Migration[8.1]
  def change
    create_table :reports do |t|
      t.string :description, null: false
      t.date :date, null: false
      t.references :file, foreign_key: { to_table: :file_assets }

      t.references :updated_by, null: false, foreign_key: { to_table: :user_accounts }
      t.timestamps
    end
  end
end
