require 'rails_helper'
describe Api::V1::BooksController, type: :controller do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'When fetching all the books' do
      let!(:books) { create_list(:book, 3) }

      before do
        get :index, params: { page: 1, page_size: 3 }
      end

      it 'respond with status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'respond with books json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          books, each_serializer: BookSerializer
        ).to_json
        expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
      end
    end
  end
  describe 'GET #show' do
    context 'When fetching a book' do
      let!(:book) { create(:book) }

      before do
        get :show, params: { id: book.id }
      end

      it 'respond with status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'respond with book json' do
        expect(JSON.parse(response.body)).to eq(JSON.parse(BookShowSerializer.new(
          book
        ).to_json))
      end
    end

    context 'When a book is not found' do
      let!(:error) { { error: 'Couldn\'t find Book with \'id\'=1000' } }

      before do
        get :show, params: { id: 1000 }
      end

      it 'respond with status 404' do
        expect(response).to have_http_status(404)
      end

      it 'respond with error json' do
        expect(JSON.parse(response.body)).to eq(JSON.parse(error.to_json))
      end
    end
  end
end
