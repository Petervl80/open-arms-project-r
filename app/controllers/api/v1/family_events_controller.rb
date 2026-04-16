module Api
    module V1
        class FamilyEventsController < ChildRecordBaseController

            private 

            def record_params
                params.require(:family_event).permit(
                    :child_id,
                    :date,
                    :description
                )
            end
        end
    end
end