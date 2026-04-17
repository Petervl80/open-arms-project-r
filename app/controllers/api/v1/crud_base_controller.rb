module Api
  module V1
    class CrudBaseController < ApplicationController
      before_action :set_record, only: [:show, :update, :destroy]

      def index
        records = model_class.respond_to?(:kept) ? model_class.kept : model_class.all

        records = records.includes(includes_for_index) if respond_to?(:includes_for_index, true)

        requested_limit = params.fetch(:limit, 20).to_i
        safe_limit = [requested_limit, 100].min

        @pagy, paginated_records = pagy(records, limit: safe_limit)

        render json: {
          data: render_with_blueprint(paginated_records),
          meta: pagy_metadata(@pagy)
        }, status: :ok
      end

      def show
        render json: {
          data: render_with_blueprint(@record, view: blueprint_show_view)
        }, status: :ok
      end

      def create
        @record = model_class.new(record_params)
        @record.updated_by_id = @current_user.id if @record.respond_to?(:updated_by_id=)

        if @record.save
          render json: { data: render_with_blueprint(@record, view: blueprint_show_view) }, status: :created
        else
          render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        @record.updated_by_id = @current_user.id if @record.respond_to?(:updated_by_id=)
        @record.assign_attributes(record_params)

        if @record.save
          render json: { data: render_with_blueprint(@record, view: blueprint_show_view) }, status: :ok
        else
          render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @record.respond_to?(:discard)
          @record.discard
          @record.update_column(:updated_by_id, @current_user.id) if @record.respond_to?(:updated_by_id=)
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

      def blueprint_class
        "#{model_class.name}Blueprint".constantize
      rescue NameError
        nil
      end

      def blueprint_show_view
        :extended 
      end

      def render_with_blueprint(data, view: :default)
        if blueprint_class
          blueprint_class.render_as_hash(data, view: view)
        else
          data.as_json
        end
      end
    end
  end
end