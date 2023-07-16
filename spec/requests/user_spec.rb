require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    let(:path) { '/api/v1/users' }
    let!(:users) { FactoryBot.create_list(:user, 10) }

    before { get path }

    it 'returns a list of users' do
      expect(response).to have_http_status(200)
      # TODO: test that the response body is the list of users
    end
  end

  describe 'GET /show' do
    let(:path) { "/api/v1/users/#{user_id}" }
    let(:user_id) { user.id }
    let!(:user) { FactoryBot.create(:user) }

    before { get path }

    it 'returns a specific user' do
      expect(response).to have_http_status(200)
      # TODO: test that the response body is the user
    end

    context 'when the user does not exist' do
      let(:user_id) { 0 }

      it 'returns a 404' do
        expect(response).to have_http_status(404)
      end
    end

    it 'returns a list of posts for the user' do
      get "#{path}?expand=posts"

      # TODO: test that the response body is the list of posts

      expect(response).to have_http_status(200)
    end
  end
end
