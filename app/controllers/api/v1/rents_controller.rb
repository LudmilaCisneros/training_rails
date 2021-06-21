module Api
  module V1
    class RentsController < ApplicationController
      before_action :authenticate_user!
      rescue_from ActionController::ParameterMissing, with: :param_missing
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

      def index
        render json: rents
      end

      def create
        return book_not_found unless Book.exists?(rent_params[:book_id])

        rent = Rent.create!(rent_params)
        render json: rent, status: :created
      end

      private

      def rents
        Rent.where(user_id: current_user.id.to_s).order(:id).page(params[:page])
            .per(params[:page_size])
      end

      def rent_params
        rent_require = params.require(:rent)
        rent_require.require(%i[book_id from to])
        rent_require.permit(:book_id, :from, :to).to_h.merge(user_id: current_user.id)
      end

      def param_missing(exc)
        render json: { 'error': exc.message }, status: :bad_request
      end

      def record_invalid(exc)
        render json: { 'error': exc.message }, status: :unprocessable_entity
      end

      def book_not_found
        render json: { error: 'The book don\'t exist' }, status: :not_found
      end
    end
  end
end
