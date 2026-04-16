class CreateSocialDevelopmentEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :social_development_entries do |t|
      t.references :child, null: false, foreign_key: true
      t.date :date, null: false
      t.text :coexistence_notes
      t.text :rules_notes

      t.references :updated_by, null: false, foreign_key: { to_table: :user_accounts }
      t.timestamps
    end
  end
end
