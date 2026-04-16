module Api
    module V1
        class HealthEventsController < ChildRecordBaseController

            private

            def includes_for_index
                :health_event_type
            end

            def record_params
                params.require(:health_event).permit(
                    :child_id,
                    :date,
                    :health_event_type_id,
                    :notes
                )
            end
        end
    end
end