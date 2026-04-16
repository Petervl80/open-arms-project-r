module Api
    module V1
        class IndividualCaresController < ChildRecordBaseController

            private

            def includes_for_index
                :individual_care_type
            end

            def record_params
                params.require(:individual_care).permit(
                    :child_id,
                    :date,
                    :individual_care_type_id,
                    :notes
                )
            end
        end
    end
end