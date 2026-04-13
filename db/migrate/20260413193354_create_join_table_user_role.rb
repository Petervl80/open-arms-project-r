class CreateJoinTableUserRole < ActiveRecord::Migration[8.1]
  def change
    create_join_table :user_accounts, :roles do |t|
      # t.index [:user_account_id, :role_id]
      # t.index [:role_id, :user_account_id]
    end
  end
end
