Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      # Cria automaticamente as rotas GET, POST, PUT, DELETE para os domínios
      resources :sex_types, only: [:index, :show]
      resources :race_types, only: [:index, :show]
      resources :blood_types, only: [:index, :show]
      resources :process_types, only: [:index, :show]
      resources :individual_care_types, only: [:index, :show]
      resources :health_event_types, only: [:index, :show]
      resources :school_event_types, only: [:index, :show]
      resources :file_types, only: [:index, :show]
      resources :family_sides, only: [:index, :show]
      resources :child_contact_roles, only: [:index, :show]

      post '/auth/login', to: 'authentication#login'

      resources :children

      # Novas rotas dedicadas para exportação, apontando para o novo controller
      scope :exports do
        get 'children/:id/xlsx', to: 'exports#export_child_xlsx'
        get 'children/:id/pdf', to: 'exports#export_child_pdf'
      end

    end
  end
end
