module Api
  module V1
    class RolesController < CrudBaseController
      
      before_action :require_admin!

      private

      def record_params
        params.require(:role).permit(:code, :name, :description, permission_ids: [])
      end

      def includes_for_index
        [:permissions]
      end
    end
  end
end