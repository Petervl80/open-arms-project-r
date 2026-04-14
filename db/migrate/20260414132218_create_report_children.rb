class CreateReportChildren < ActiveRecord::Migration[8.1]
  def change
    create_table :report_children do |t|
      t.references :report, null: false, foreign_key: true
      t.references :child, null: false, foreign_key: true

      t.references :updated_by, null: false, foreign_key: { to_table: :user_accounts }
      t.timestamps
    end
    add_index :report_children, [:report_id, :child_id], unique: true
  end
end
