module Api
  module V1
    class ChildRecordBaseController < CrudBaseController
      
      #before_action :require_technical_team!

      def index
        records = model_class.all

        if params[:child_id].present?
          records = records.where(child_id: params[:child_id])
        end

        records = records.order(date: :desc)

        if respond_to?(:includes_for_index, true)
          records = records.includes(includes_for_index)
        end

        render json: records, include: respond_to?(:includes_for_index, true) ? includes_for_index : [], status: :ok
      end

      def show
        render json: @record, include: respond_to?(:includes_for_index, true) ? includes_for_index : [], status: :ok 
      end
    end
  end
end