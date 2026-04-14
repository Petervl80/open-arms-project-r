module Api
    module V1
        class AuthenticationController < ApplicationController

            skip_before_action :authorize_request, only: :login

            # POST /api/v1/auth/login
            def login
                @user = UserAccount.find_by(email: params[:email])

                # O método .authenticate vem do has_secure_password
                if @user&.authenticate(params[:password])

                    # Gera o token embutindo o ID do usuário
                    token = JsonWebToken.encode(user_id: @user.id)
                    time = Time.now + 24.hours.to_i

                    render json: {
                        token: token,
                        exp: time.strftime("%m-%d-%Y %H:%M"),
                        full_name: @user.full_name
                    }, status: :ok
                else
                    render json: { errors: 'E-mail ou senha inválidos' }, status: :unauthorized
                end
            end
        end
    end
end