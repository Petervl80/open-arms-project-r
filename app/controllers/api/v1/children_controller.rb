module Api
  module V1
    class ChildrenController < CrudBaseController
      
      #before_action :require_technical_team!, only: [:create, :update, :destroy]

      private

      def includes_for_index
        [:sex_type, :race_type, :process_type]
      end

      def record_params
        params.require(:child).permit(
          :full_name, :process_number, :birth_date, :cpf, :rg, :nationality, 
          :place_of_birth, :disability_notes, :registry_office, :birth_certificate_number,
          :sex_type_id, :race_type_id, :blood_type_id, :process_type_id,
          child_contacts_attributes: [
            :id, :contact_id, :child_contact_role_id, :sequence, :is_primary, :_destroy
          ]
        )
      end
    end
  end
end