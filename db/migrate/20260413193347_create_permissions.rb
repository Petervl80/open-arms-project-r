class CreatePermissions < ActiveRecord::Migration[8.1]
  def change
    create_table :permissions do |t|
      t.string :description

      t.timestamps
    end
    add_index :permissions, :description
  end
end
