module Api
    module V1
        class AlarmsController < ChildRecordBaseController

            private 

            def record_params
                params.require(:alarm).permit(
                    :child_id,
                    :date,
                    :description
                )
            end
        end
    end
end