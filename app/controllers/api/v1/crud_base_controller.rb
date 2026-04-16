module Api
  module V1
    class CrudBaseController < ApplicationController
      before_action :set_record, only: [:show, :update, :destroy]

      def index
        records = model_class.respond_to?(:kept) ? model_class.kept : model_class.all

        @pagy, paginated_records = pagy(records)

        render json: {
          data: paginated_records,
          meta: pagy_metadata(@pagy)
        }, status: :ok
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
        
        if @record.respond_to?(:discard)
          @record.discard
          
          if @record.respond_to?(:updated_by_id=)
            @record.update_column(:updated_by_id, @current_user.id)
          end
        else
          @record.destroy
        end
        
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