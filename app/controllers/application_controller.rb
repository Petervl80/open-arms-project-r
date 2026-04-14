class ApplicationController < ActionController::API

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
end
