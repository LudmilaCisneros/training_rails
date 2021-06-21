require 'devise/jwt/test_helpers'

RSpec.shared_context 'Authenticated User' do
  let(:user) { create(:user) }
  let!(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }

  before do
    request.headers['Authorization'] = auth_headers['Authorization']
  end
end
