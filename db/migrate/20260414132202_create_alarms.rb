class CreateAlarms < ActiveRecord::Migration[8.1]
  def change
    create_table :alarms do |t|
      t.references :child, null: false, foreign_key: true
      t.date :date, null: false
      t.text :description, null: false
      t.boolean :completed, default: false

      t.references :updated_by, null: false, foreign_key: { to_table: :user_accounts }
      t.timestamps
    end
  end
end
