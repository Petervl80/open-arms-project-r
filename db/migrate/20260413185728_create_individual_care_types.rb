class CreateIndividualCareTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :individual_care_types do |t|
      t.string :description, null: false

      t.timestamps
    end
    add_index :individual_care_types, :description, unique: true
  end
end
