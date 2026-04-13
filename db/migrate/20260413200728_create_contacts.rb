class CreateContacts < ActiveRecord::Migration[8.1]
  def change
    create_table :contacts do |t|
      t.string :full_name, limit: 50, null: false
      t.string :phone, limit: 20
      t.references :family_side, null: true, foreign_key: true
      
      t.string :street, limit: 50
      t.string :district, limit: 50
      t.string :city, limit: 50
      t.string :state, limit: 30
      t.string :occupation, limit: 30
      t.text :notes
      
      t.references :updated_by, null: false, foreign_key: { to_table: :user_accounts }

      t.timestamps
    end
  end
end