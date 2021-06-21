module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      def create
        user = User.create!(user_params)
        render json: user, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { 'error': e.message }, status: :unprocessable_entity
      rescue ActionController::ParameterMissing => e
        render json: { 'error': e.message }, status: :bad_request
      end

      private

      def user_params
        params.require(%i[email password password_confirmation first_name last_name])
        params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
      end
    end
  end
end
