require 'rails_helper'

describe Api::V1::RentsController, type: :controller do
  include_context 'Authenticated User'

  let!(:book) do
    create(:book)
  end

  describe 'GET #index' do
    context 'When fetching all the rents' do
      let!(:rents) { create_list(:rent, 3, user_id: user.id) }

      before do
        get :index, params: { page: 1, page_size: 1 }
      end

      it 'respond with rents json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          Array(rents.min_by(&:id)), each_serializer: RentSerializer
        ).to_json
        expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
      end

      it 'respond with status ok' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'When creating a rent' do
      let(:rent_params) do
        { rent: { book_id: book.id, from: rent.from,
                  to: rent.to } }
      end
      let(:rent) { build(:rent, user_id: user.id, book: book) }

      before do
        post :create, params: rent_params
      end

      it 'creates the rent' do
        id = JSON.parse(response.body)['id']
        expect(Rent.find(id)).to be_present
      end

      it 'respond with status created' do
        expect(response).to have_http_status(:created)
      end

      it 'enqueues a job' do
        expect(ContactUserWorker.jobs.size).to eq(1)
      end
    end

    context "When the book doesn't exist" do
      let!(:error) { { error: 'The book don\'t exist' } }
      let(:rent_params) do
        { rent: { book_id: 1000, from: '2016-01-10',
                  to: '2016-02-04' } }
      end

      before do
        post :create, params: rent_params
      end

      it 'respond with error json' do
        expect(JSON.parse(response.body)).to eq(JSON.parse(error.to_json))
      end

      it 'respond with status not found' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'When a required parameter is missing' do
      let(:rent_params) do
        { rent: { book_id: book.id, from: '2016-01-10' } }
      end

      before do
        post :create, params: rent_params
      end

      it 'respond with status bad request' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'When from is invalid' do
      let(:rent_params) do
        { rent: { book_id: book.id, from: 'fake',
                  to: '2016-02-04' } }
      end

      before do
        post :create, params: rent_params
      end

      it 'respond with status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When to is invalid' do
      let(:rent_params) do
        { rent: { book_id: book.id, from: '2016-02-04',
                  to: 'fake' } }
      end

      before do
        post :create, params: rent_params
      end

      it 'respond with status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
