class JsonWebToken
    # Usa a chave secreta do próprio Rails para assinar o token
    SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

    # Gera o token (por padrão, expira em 24 horas)
    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end

    # Descriptografa e verifica o token
    def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new decoded 
    end
end