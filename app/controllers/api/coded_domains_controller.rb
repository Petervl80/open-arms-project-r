module Api
    module V1
        class CodedDomainsController < ApplicationController

            def index
                domains = model_class.all
                render json: domains, status: :ok
            end

            def show 
                domain = model_class.find(params[:id])
                render json: domain, status: :ok
            end

            private

            def model_class
                controller_name.classify.constantize
            end
        end
    end
end