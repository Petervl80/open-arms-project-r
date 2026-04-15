class CreateRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :roles do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
    add_index :roles, :code, unique: true
  end
end
