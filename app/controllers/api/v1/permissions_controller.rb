module Api
  module V1
    class PermissionsController < CrudBaseController
      
      # before_action :require_admin!

      private

      def record_params
        params.require(:permission).permit(:code, :description)
      end
    end
  end
end