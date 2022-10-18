class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment
    end

    def create
        apartment = Apartment.create(apartment_params)
        render json: apartment
    end

    def update
        apartment = Apartment.find(params[:id])
        render json: apartment
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        render json: { }
    end

    private

    def apartment_params
        params.permit(:id, :number)
    end

    def render_not_found
        render json: { error: "Record not found"}, status: :not_found
    end

    def render_unprocessable
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
