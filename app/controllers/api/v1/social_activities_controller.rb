module Api
    module V1
        class SocialActivitiesController < ChildRecordBaseController

            private

            def record_params
                params.require(:social_activity).permit(
                    :child_id,
                    :date,
                    :event
                )
            end
        end
    end
end