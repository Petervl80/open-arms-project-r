class CreateChildContactRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :child_contact_roles do |t|
      t.string :description, null: false

      t.timestamps
    end
    add_index :child_contact_roles, :description, unique: true
  end
end
