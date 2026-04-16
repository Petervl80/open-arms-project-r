class AddDeletedAtToMainTables < ActiveRecord::Migration[8.1]
  def change
    # Entidades Principais
    add_column :children, :deleted_at, :datetime
    add_index :children, :deleted_at

    add_column :user_accounts, :deleted_at, :datetime
    add_index :user_accounts, :deleted_at

    add_column :contacts, :deleted_at, :datetime
    add_index :contacts, :deleted_at

    # Documentos
    add_column :reports, :deleted_at, :datetime
    add_index :reports, :deleted_at

    add_column :file_assets, :deleted_at, :datetime
    add_index :file_assets, :deleted_at

    # Eventos Datados (Exemplos principais)
    add_column :action_plan_items, :deleted_at, :datetime
    add_index :action_plan_items, :deleted_at
    
    add_column :family_events, :deleted_at, :datetime
    add_index :family_events, :deleted_at
    
    add_column :individual_cares, :deleted_at, :datetime
    add_index :individual_cares, :deleted_at
    
    add_column :school_progresses, :deleted_at, :datetime
    add_index :school_progresses, :deleted_at
    
    add_column :health_events, :deleted_at, :datetime
    add_index :health_events, :deleted_at
    
    add_column :social_development_entries, :deleted_at, :datetime
    add_index :social_development_entries, :deleted_at
    
    add_column :social_activities, :deleted_at, :datetime
    add_index :social_activities, :deleted_at
    
    add_column :alarms, :deleted_at, :datetime
    add_index :alarms, :deleted_at
  end
end