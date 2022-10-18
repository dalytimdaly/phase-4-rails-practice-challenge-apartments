class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable
    
    def create
        lease = Lease.create(lease_params)

    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        render json: { }
    end

    private

    def lease_params
        params.permit(:rent, :id, :apartment_id, :tenant_id)
    end
    
    def render_not_found
        render json: { error: "Record not found"}, status: :not_found
    end

    def render_unprocessable
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
