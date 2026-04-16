module Api
  module V1
    class ChildrenController < CrudBaseController
      
      #before_action :require_technical_team!, only: [:create, :update, :destroy]

      def index
        records = model_class.respond_to?(:kept) ? model_class.kept : model_class.all
        
        records = records.includes(:sex_type, :race_type, :process_type)

        render json: records, include: [:sex_type, :race_type, :process_type], status: :ok
      end

      def show
        render json: @record, include: [
          :sex_type, :race_type, :blood_type, :process_type,
          { child_contacts: { include: [:contact, :child_contact_role] } }
        ], status: :ok
      end

      def create
        @record = Child.new(record_params)
        @record.updated_by_id = @current_user.id if @record.respond_to?(:updated_by_id=)

        # Injeta a auditoria em cada contato que está a ser criado junto com a criança
        @record.child_contacts.each do |contact|
          contact.updated_by_id = @current_user.id if contact.respond_to?(:updated_by_id=)
        end

        if @record.save
          render json: @record, status: :created
        else
          render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        @record.updated_by_id = @current_user.id if @record.respond_to?(:updated_by_id=)
        @record.assign_attributes(record_params)

        @record.child_contacts.each do |contact|
          contact.updated_by_id = @current_user.id if contact.respond_to?(:updated_by_id=)
        end

        if @record.save
          render json: @record, status: :ok
        else
          render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

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