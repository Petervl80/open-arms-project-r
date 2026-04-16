module Api
    module V1
        class ReportsController < CrudBaseController

            #before_action :require_technical_team!

            def index

                records = model_class.includes(:children, :file_asset).order(date: :desc)

                if params[:child_id].present?
                    records = records.joins(:report_children).where(report_children: { child_id: params[:child_id] })
                end

                render json: records, include: [:children, :file_asset], status: :ok
            end

            def show
                render json: @record, include: [:children, :file_asset], status: :ok
            end

            def create
                # Remove os child_ids dos parâmetros principais para o Rails não tentar salvar magicamente
                child_ids = params[:report].delete(:child_ids) || []

                @record = Report.new(record_params)
                @record.updated_by_id = @current_user.id

                if @record.save
                    # Cria os vínculos na tabela de junção preenchendo a auditoria manualmente
                    child_ids.each do |child_id|
                        ReportChild.create!(
                        report_id: @record.id, 
                        child_id: child_id, 
                        updated_by_id: @current_user.id
                        )
                end
                    render json: @record, status: :created
                else
                    render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
                end
            end

            private

            def record_params
                # O Rails encarrega-se de criar e apagar os registos na tabela `ReportChild` automaticamente
                params.require(:report).permit(
                    :date, 
                    :description, 
                    :file_id, 
                    child_ids: [])
            end
        end
    end
end
                