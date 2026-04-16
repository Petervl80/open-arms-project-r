module Api
    module V1
        class ActionPlanItemsController < ChildRecordBaseController

            private 

            def record_params
                params.require(:action_plan_item).permit(
                    :child_id,
                    :date,
                    :activity
                )
            end
        end
    end
end