class CreateHealthEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :health_events do |t|
      t.references :child, null: false, foreign_key: true
      t.date :date, null: false
      t.references :health_event_type, null: false, foreign_key: true
      t.text :notes
      
      t.references :updated_by, null: false, foreign_key: { to_table: :user_accounts }
      t.timestamps
    end
  end
end
