module Api
    module V1
        class ChildrenController < ApplicationController

            before_action :set_child, only: [:show, :update, :destroy]

            # GET /api/v1/children
            def index
                @children = Child.includes(:sex_types, :race_types, :process_types).all

                render json: @children, include: [:sex_type, :race_type, :process_type], status: :ok
            end

            # GET /api/v1/children/1
            def show
                render json: @child, include: [
                :sex_type, :race_type, :blood_type, :process_type,
                { child_contacts: { include: [:contact, :child_contact_role] } }
                ], status: :ok
            end

            # POST /api/v1/children
            def create
                @child = Child.new(child_params)
                
                @child.updated_by_id = @current_user.id

                @child.child_contacts.each do |nested_contact|
                    nested_contact.updated_by_id = @current_user.id
                end

                if @child.save
                    render json: @child, status: :created
                else
                    render json: { errors: @child.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # PUT /api/v1/children/1
            def update
                @child.updated_by_id = @current_user.id
                @child.assign_attributes(child_params)

                @child.child_contacts.each { |cc| cc.updated_by_id = @current_user.id }

                if @child.save
                    render json: @child, status: :ok
                else
                    render json: { errors: @child.errors.full_messages }, status: :unprocessable_entity
                end
            end

            # DELETE /api/v1/children/1
            def destroy
                @child.destroy
                head :no_content
            end

            private

            def set_child
                @child = Child.find(params[:id])
            end

            def child_params
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

