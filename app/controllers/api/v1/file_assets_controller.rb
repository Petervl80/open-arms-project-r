module Api
    module V1
        class FileAssetsController < CrudBaseController
      
            #before_action :require_technical_team!

            before_action :set_record, only: [:show, :update, :destroy, :download]

            def create
                uploaded_file = params[:file]

                if uploaded_file.blank?
                    return render json: { error: 'Nenhum arquivo enviado.' }, status: :unprocessable_entity
                end

                # 1. Preparar a pasta de destino (storage/uploads)
                upload_dir = Rails.root.join('storage', 'uploads')
                FileUtils.mkdir_p(upload_dir) unless File.directory?(upload_dir)

                # 2. Gerar um nome único para não sobrescrever arquivos com o mesmo nome
                extension = File.extname(uploaded_file.original_filename)
                base_name = File.basename(uploaded_file.original_filename, extension)
                unique_filename = "#{base_name}_#{Time.now.to_i}_#{SecureRandom.hex(4)}#{extension}"
                file_path = upload_dir.join(unique_filename)

                # 3. Salvar o arquivo fisicamente no servidor
                File.open(file_path, 'wb') do |file|
                    file.write(uploaded_file.read)
                end

                # 4. Criar o registro no banco de dados populando os metadados automaticamente
                @record = FileAsset.new(
                file_type_id: params[:file_type_id],
                original_file_name: uploaded_file.original_filename,
                mime_type: uploaded_file.content_type,
                size_bytes: uploaded_file.size,
                storage_path_or_url: file_path.to_s
                )

                @record.updated_by_id = @current_user.id if @record.respond_to?(:updated_by_id=)

                if @record.save
                    render json: @record, status: :created
                else
                    # Segurança: Se o banco de dados falhar, apagamos o arquivo físico que acabou de ser salvo
                    File.delete(file_path) if File.exist?(file_path)
                    render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
                end
            end

            def destroy 
                file_path = @record.storage_path_or_url

                if @record.destroy
                    File.delete(file_path) if file_path.present? && File.exist?(file_path)
                    head :no_content
                else
                    render json: { errors: 'Não foi possível deletar o arquivo' }, status: :unprocessable_entity
                end
            end

            def download
                file_path = @record.storage_path_or_url

                if File.exist?(file_path)
                    # 'send_file' é um método nativo do Rails para enviar binários
                    send_file file_path,
                        filename: @record.original_file_name,
                        type: @record.mime_type,
                        disposition: 'attachment' # Mude para 'inline' se quiser abrir no navegador (ex: PDF/Imagem)
                else
                    render json: { error: 'Arquivo físico não encontrado no servidor' }, status: :not_found
                end
            end

            private

            def record_params
                params.require(:file_asset).permit(:file_type_id)
            end
        end
    end
end