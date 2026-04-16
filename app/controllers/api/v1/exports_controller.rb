# app/controllers/api/v1/exports_controller.rb
module Api
  module V1
    class ExportsController < ApplicationController
      
      include ActionController::MimeResponds
      include ActionView::Layouts

      before_action :set_child, only: [:export_child_xlsx, :export_child_pdf]

      # GET /api/v1/exports/children/:id/xlsx
      def export_child_xlsx
        # A lógica de busca continua a mesma
        @child = Child.includes(
          :sex_type, :blood_type, :process_type,
          :action_plan_items, :health_events, :school_progresses,
          :social_activities, :family_events,
          { child_contacts: [:contact, :child_contact_role] }
        ).find(params[:id])

        file_name = "PIA_#{@child.full_name.parameterize}.xlsx"
        response.headers['Content-Disposition'] = "attachment; filename=\"#{file_name}\""

        respond_to do |format|
          format.xlsx {
            render xlsx: "export_xlsx", 
                   # Atualize o caminho do template para a nova pasta (ver Passo 4)
                   template: "api/v1/exports/export_child_xlsx", 
                   filename: file_name
          }
        end
      end

      # GET /api/v1/exports/children/:id/pdf
      def export_child_pdf
        # Lógica para PDF
      end

      private

      def set_child
        @child = Child.find(params[:id])
      end
    end
  end
end