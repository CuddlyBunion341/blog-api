require 'rails_helper'

RSpec.describe 'Users::Sessions', type: :request do
  describe 'GET /index' do
    let(:path) { '/api/v1/user' }
    let!(:user) { FactoryBot.create(:user) }

    context 'when user is not logged in' do
      it 'returns 401' do
        get path
        expect(response).to have_http_status(401)
      end
    end

    context 'when user is logged in' do
      it 'returns 200' do
        sign_in_as(user)
        get path
        expect(response).to have_http_status(200)
      end
    end
  end
end
