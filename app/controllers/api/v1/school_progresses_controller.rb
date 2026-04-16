module Api
    module V1
        class SchoolProgressesController < ChildRecordBaseController

            private

            def includes_for_index
                :school_event_type
            end

            def record_params
                params.require(:school_event).permit(
                    :child_id,
                    :date,
                    :school_event_type_id,
                    :notes
                )
            end
        end
    end
end