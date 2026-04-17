class ApplicationController < ActionController::API
  include Pagy::Method

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 

  before_action :authorize_request

  private

  def require_permission!(permission_code)
    unless @current_user&.has_permission?(permission_code)
      render json: { error: "Acesso negado. Necessária a permissão: #{permission_code}" }, status: :forbidden
    end
  end
  
  def require_admin!
    unless @current_user&.admin?
      render json: { error: 'Acesso negado. Apenas administradores.' }, status: :forbidden
    end
  end

  def authorize_request
    
    header = request.headers['Authorization']

    # Validação rigorosa: Verifica se o cabeçalho existe E se começa com "Bearer "
    if header.present? && header.start_with?('Bearer ')
      # Remove a palavra "Bearer " para isolar apenas o token JWT
      token = header.split(' ').last 
      
      begin
        @decoded = JsonWebToken.decode(token)
        @current_user = UserAccount.find(@decoded[:user_id])

        unless @current_user.enabled?
          return render json: { errors: 'Sua conta foi desativada. Entre em contato com a administração.' }, status: :unauthorized
        end

      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: 'Usuário não encontrado' }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: 'Sessão inválida ou expirada (Token Inválido)' }, status: :unauthorized
      end
    else
      render json: { errors: 'Acesso negado. Formato esperado no Header: Authorization: Bearer <token>' }, status: :unauthorized
    end
  end

  def record_not_found(exception)
    # Tenta traduzir o nome do modelo (ex: "Child" vira "Criança" se o locale estiver em PT)
    model_name = exception.model.constantize.model_name.human rescue "Registro"
    render json: { error: "#{model_name} não encontrado(a) no sistema." }, status: :not_found
  end

  def pagy_metadata(pagy)
    {
      page: pagy.page,
      limit: pagy.limit,
      count: pagy.count,
      pages: pagy.pages,
      has_next: pagy.page < pagy.pages,
      has_prev: pagy.page > 1
    }
  end

end
