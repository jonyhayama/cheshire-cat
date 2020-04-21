module Api
	module V1
    class RecordsController < ApplicationController 
      def index
        records = Record.order('created_at DESC');
				render json: { total_records: records.count, records: records }, status: :ok
      end

      def create
        record = Record.new(record_params)
        if record.save
          render json: { id: record.id }, status: :ok
        else
          render json: { data: record.errors }, status: :unprocessable_entity
        end
      end

      private

      def record_params
        params.permit(:ip, hostnames_attributes: [ :name ])
      end
		end
	end
end