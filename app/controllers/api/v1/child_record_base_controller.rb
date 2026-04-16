module Api
  module V1
    class ChildRecordBaseController < CrudBaseController
      
      #before_action :require_technical_team!

      def index
        records = model_class.respond_to?(:kept) ? model_class.kept : model_class.all

        if params[:child_id].present?
          records = records.where(child_id: params[:child_id])
        end

        records = records.order(date: :desc)

        # Prevenção de N+1 Queries
        if respond_to?(:includes_for_index, true)
          records = records.includes(includes_for_index)
        end

        @pagy, paginated_records = pagy(records)

        render json: {
          data: paginated_records.as_json(include: respond_to?(:includes_for_index, true) ? includes_for_index : []),
          meta: pagy_metadata(@pagy)
        }, status: :ok
      end

      def show
        render json: @record, include: respond_to?(:includes_for_index, true) ? includes_for_index : [], status: :ok 
      end
    end
  end
end