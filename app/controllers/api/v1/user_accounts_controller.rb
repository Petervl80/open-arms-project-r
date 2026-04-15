module Api
    module V1
        class UserAccountsController < ApplicationController
            before_action :set_user_account, only: [:show, :update, :destroy]

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
                @user_account = UserAccount.new(user_account_params)

                if @user_account.save
                    render json: @user_account.as_json(except: [:password_digest]), status: :created
                else 
                   render json: { errors: @user_account.errors.full_messages }, status: :unprocessable_entity 
                end
            end

            # PUT /api/v1/user_accounts/1
            def update
                clean_params = user_account_params
                clean_params.delete(:password) if clean_params[:password].blank?

                if @user_account.update(clean_params)
                    render json: @user_account.as_json(except: [:password_digest]), status: :ok
                else 
                    render json: { errors: @user_account.errors.full_messages }, status: :unprocessable_entity
                end
            end

            private

            def set_user_account
                @user_account = UserAccount.find(params[:id])
            rescue ActiveRecord::RecordNotFound
                render json: { error: 'Usuário não encontrado' }, status: :not_found
            end

            def user_account_params
                params.require(:user_account).permit(
                :email, :password, :full_name, 
                :enabled, :account_non_expired, :account_non_locked, :credentials_non_expired,
                role_ids: [] 
                )
            end
        end
    end
end