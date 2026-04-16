module Api
    module V1
        class UserAccountsController < ApplicationController
            before_action :set_user_account, only: [:show, :update, :destroy, :toggle_status]

            # Regras de autorização por ação
            before_action :authorize_admin_or_tech!, only: [:index, :create, :toggle_status]
            before_action :authorize_owner_or_privileged!, only: [:show, :update]
            before_action :authorize_admin_only!, only: [:destroy]

            # GET /api/v1/user_accounts
            def index
                @user_accounts = UserAccount.includes(:roles).all

                render json: @user_accounts.as_json(
                    except: [:password_disgest],
                    include: { roles: { only: [:id, :name] } }
                ), status: :ok
            end

            # GET /api/v1/user_accounts/1
            def show 
                render json: @user_account.as_json(
                    except: [:password_digest],
                    include: { roles: { only: [:id, :name] } }
                ), status: :ok
            end

            # POST /api/v1/user_accounts
            def create

                if assigning_admin_role? && !@current_user.admin?
                    return render json: { error: 'Ação não permitida' }, status: :forbidden
                end

                @user_account = UserAccount.new(user_account_params)

                if @user_account.save
                    render json: @user_account.as_json(except: [:password_digest]), status: :created
                else 
                   render json: { errors: @user_account.errors.full_messages }, status: :unprocessable_entity 
                end
            end

            # PUT /api/v1/user_accounts/1
            def update

                if attempting_to_change_roles? && !@current_user.privileged?
                    return render json: { error: 'Você não tem permissão para alterar cargos' }, status: :forbidden
                end

                if assigning_admin_role? && !@current_user.admin?
                    return render json: { error: 'Ação não permitida para o seu nível de acesso' }, status: :forbidden
                end

                clean_params = user_account_params
                clean_params.delete(:password) if clean_params[:password].blank?

                if @user_account.update(clean_params)
                    render json: @user_account.as_json(except: [:password_digest]), status: :ok
                else 
                    render json: { errors: @user_account.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # DELETE /api/v1/user_accounts/:id
            def destroy
                @user_account.destroy
                head :no_content
            end

            # PATCH /api/v1/user_accounts/:id/toggle_status
            def toggle_status
                if @user_account.update(enabled: !user_account.enabled)
                    render json: {
                        message: "Usuário #{@user_account.enabled ? 'ativado' : 'desativado'} com sucesso",
                        enabled: @user_account.enabled
                    }, status: :ok
                else
                    render json: { errors: @user_account.errors.full_messages }, status: :unprocessable_entity
                end
            end

            private

            def set_user_account
                @user_account = UserAccount.find(params[:id])
            end

            def user_account_params
                params.require(:user_account).permit(
                :email, :password, :full_name, 
                :enabled, :account_non_expired, :account_non_locked, :credentials_non_expired,
                role_ids: [] 
                )
            end

            # --- Métodos de Verificação de Papéis ---

            def attempting_to_change_roles?
                params[:user_account] && params[:user_account].key?(:role_ids)
            end

            def assigning_admin_role?
                return false unless attempting_to_change_roles?
                
                admin_role_id = Role.find_by(name: 'ADMIN')&.id
                params[:user_account][:role_ids].map(&:to_i).include?(admin_role_id)
            end

            # --- Métodos de Autorização ---

            def authorize_admin_or_tech!
                unless @current_user.privileged?
                    render json: { error: 'Acesso negado' }, status: :forbidden
                end
            end

            def authorize_owner_or_privileged!
                is_owner = @user_account.id == @current_user.id
                unless is_owner || @current_user.privileged?
                    render json: { error: 'Você não tem permissão para esta ação' }, status: :forbidden
                end
            end

            def authorize_admin_only!
                unless @current_user.admin?
                    render json: { error: 'Ação não permitida' }, status: :forbidden
                end
            end

        end
    end
end