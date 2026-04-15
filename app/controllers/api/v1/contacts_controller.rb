module Api
    module V1
        class ContactsController < CrudBaseController

            def index
                @records = Contact.includes(:family_side).all
                render json: @records, include: :family_side, status: :ok 
            end

            def show 
                render json: @record, include: :family_side, status: :ok
            end

            private
            
            def record_params
                params.require(:contact).permit(
                    :full_name, :occupation, :phone, :family_side_id,
                    :street, :district, :city, :state, :notes
                )
            end
        end
    end
end