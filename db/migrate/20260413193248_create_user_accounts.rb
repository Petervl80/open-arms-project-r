class CreateUserAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :user_accounts do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :full_name
      t.boolean :enabled, default: true
      t.boolean :account_non_expired, default: true
      t.boolean :account_non_locked, default: true
      t.boolean :credentials_non_expired, default: true

      t.timestamps
    end
    add_index :user_accounts, :email, unique: true
  end
end
