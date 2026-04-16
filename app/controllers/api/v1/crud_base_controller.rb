module Api
  module V1
    class CrudBaseController < ApplicationController
      before_action :set_record, only: [:show, :update, :destroy]

      def index
        render json: model_class.all, status: :ok
      end

      def show
        render json: @record, status: :ok
      end

      def create
        @record = model_class.new(record_params)
        
        if @record.respond_to?(:updated_by_id=)
          @record.updated_by_id = @current_user.id
        end

        if @record.save
          render json: @record, status: :created
        else
          render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @record.respond_to?(:updated_by_id=)
          @record.updated_by_id = @current_user.id
        end

        if @record.update(record_params)
          render json: @record, status: :ok
        else
          render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @record.destroy
        head :no_content
      end

      private

      def set_record
        @record = model_class.find(params[:id])
      end

      def model_class
        controller_name.classify.constantize
      end

      # Obriga o controller filho a definir quais parâmetros são permitidos
      def record_params
        raise NotImplementedError, "Você precisa definir o método 'record_params' no controller filho."
      end
    end
  end
end