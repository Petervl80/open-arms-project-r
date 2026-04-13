class CreateChildContacts < ActiveRecord::Migration[8.1]
  def change
    create_table :child_contacts do |t|
      t.references :child, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true
      t.references :child_contact_role, null: false, foreign_key: true
      
      t.integer :sequence
      t.boolean :is_primary, default: false
      
      t.references :updated_by, null: false, foreign_key: { to_table: :user_accounts }

      t.timestamps
    end
    
    add_index :child_contacts, [:child_id, :contact_id], unique: true
  end
end