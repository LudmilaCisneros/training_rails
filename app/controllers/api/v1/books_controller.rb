module Api
  module V1
    class BooksController < ApplicationController
      before_action :authenticate_user!

      def show
        render json: book_id, serializer: BookShowSerializer
      rescue ActiveRecord::RecordNotFound => e
        render json: { 'error': e.message }, status: :not_found
      end

      def index
        render json: books
      end

      private

      def books
        Book.page(params[:page]).per(params[:page_size])
      end

      def book_id
        Book.find(book_params)
      end

      def book_params
        params.require(:id)
      end
    end
  end
end
