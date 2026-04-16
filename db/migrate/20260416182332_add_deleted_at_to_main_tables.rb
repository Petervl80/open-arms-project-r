class AddDeletedAtToMainTables < ActiveRecord::Migration[8.1]
  def change
    # Entidades Principais
    add_column :children, :discarded_at, :datetime
    add_index :children, :discarded_at

    add_column :user_accounts, :discarded_at, :datetime
    add_index :user_accounts, :discarded_at

    add_column :contacts, :discarded_at, :datetime
    add_index :contacts, :discarded_at

    # Documentos
    add_column :reports, :discarded_at, :datetime
    add_index :reports, :discarded_at

    add_column :file_assets, :discarded_at, :datetime
    add_index :file_assets, :discarded_at

    # Eventos Datados (Exemplos principais)
    add_column :action_plan_items, :discarded_at, :datetime
    add_index :action_plan_items, :discarded_at
    
    add_column :family_events, :discarded_at, :datetime
    add_index :family_events, :discarded_at
    
    add_column :individual_cares, :discarded_at, :datetime
    add_index :individual_cares, :discarded_at
    
    add_column :school_progresses, :discarded_at, :datetime
    add_index :school_progresses, :discarded_at
    
    add_column :health_events, :discarded_at, :datetime
    add_index :health_events, :discarded_at
    
    add_column :social_development_entries, :discarded_at, :datetime
    add_index :social_development_entries, :discarded_at
    
    add_column :social_activities, :discarded_at, :datetime
    add_index :social_activities, :discarded_at
    
    add_column :alarms, :discarded_at, :datetime
    add_index :alarms, :discarded_at
  end
end