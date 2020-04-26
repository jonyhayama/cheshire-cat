module Api
	module V1
    class RecordsController < ApplicationController 
      def index
        page = params[:page]
        return render json: { error: [ { page: "required param" } ] }, status: :unprocessable_entity unless page

        records = Record.joins(:hostnames)
        excluded = records.select(:id).where('hostnames.name IN (?)', params[:excluded]).distinct.pluck(:id) if params[:excluded].present?
        records = records.where('hostnames.name IN (?)', params[:included]) if params[:included].present?
        records = records.where('records.id NOT IN (?)', excluded) if excluded.present?
        records = records.select('records.id', 'records.ip', 'COUNT(hostnames.name) as count').group('records.id')
        records = records.to_a
        records = records.select{ |r| r.count == params[:included].count } if params[:included].present?
        total_records = records.count

        records_ids = records.pluck(:id)
        excluded_hostnames = [params[:included], params[:excluded]].flatten.compact
        hostnames = Hostname.joins(:records).select('hostnames.name, COUNT(*) AS count').group('hostnames.name')
        hostnames = hostnames.where('records.id IN (?)', records_ids) if records_ids.present?
        hostnames = hostnames.where('hostnames.name NOT IN (?)', excluded_hostnames) if excluded_hostnames.present?
        related_hostnames = hostnames.map{ |h| { name: h.name, count: h.count } }

				render json: { 
          total_records: total_records, 
          records: records,
          related_hostnames: related_hostnames
        }, status: :ok
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