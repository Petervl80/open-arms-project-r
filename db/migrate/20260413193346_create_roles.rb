class CreateRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :roles do |t|
      t.string :code
      t.string :name
      t.string :description

      t.timestamps
    end
    add_index :roles, :code
  end
end
