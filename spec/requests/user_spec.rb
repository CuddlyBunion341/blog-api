require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    let(:path) { '/api/users' }
    let!(:users) { FactoryBot.create_list(:user, 10) }

    before { get path }

    it 'returns a list of users' do
      expect(response).to have_http_status(200)
      expect(response.body).to eq(users.to_json)
    end
  end

  describe 'GET /show' do
    let(:path) { "/api/users/#{user_id}" }
    let(:user_id) { user.id }
    let!(:user) { FactoryBot.create(:user) }

    before { get path }

    it 'returns a specific user' do
      expect(response).to have_http_status(200)
      expect(response.body).to eq(user.to_json)
    end

    context 'when the user does not exist' do
      let(:user_id) { 0 }

      it 'returns a 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
