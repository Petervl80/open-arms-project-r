module Api
    module V1
        class SocialDevelopmentEntriesController < ChildRecordBaseController

            private

            def record_params
                params.require(:school_event).permit(
                    :child_id,
                    :date,
                    :coexistence_notes,
                    :rules_notes
                )
            end
        end
    end
end