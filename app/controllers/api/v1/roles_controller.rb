module Api
  module V1
    class RolesController < CrudBaseController
      
      # before_action :require_admin!

      private

      def record_params
        params.require(:role).permit(:code, :name, :description)
      end
    end
  end
end