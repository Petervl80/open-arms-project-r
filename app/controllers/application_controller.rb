class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 

  before_action :authorize_request

  private

  def authorize_request
    
    header = request.headers['Authorization']

    # Validação rigorosa: Verifica se o cabeçalho existe E se começa com "Bearer "
    if header.present? && header.start_with?('Bearer ')
      # Remove a palavra "Bearer " para isolar apenas o token JWT
      token = header.split(' ').last 
      
      begin
        @decoded = JsonWebToken.decode(token)
        @current_user = UserAccount.find(@decoded[:user_id])
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

end
