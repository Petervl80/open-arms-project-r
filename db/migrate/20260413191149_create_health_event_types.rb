class CreateHealthEventTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :health_event_types do |t|
      t.string :description, null: false

      t.timestamps
    end
    add_index :health_event_types, :description, unique: true
  end
end
