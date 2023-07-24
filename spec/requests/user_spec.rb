require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include AuthHelper

  describe 'GET /index' do
    let(:path) { '/api/v1/users' }
    let!(:users) { FactoryBot.create_list(:user, 10) }
    let!(:posts) { FactoryBot.create_list(:post, 10, author: users.first) }

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

      expect(response.body).to include('posts')
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /current' do
    let(:path) { '/api/v1/users/current' }
    let!(:user) { FactoryBot.create(:user) }

    context 'when the user is not logged in' do
      before(:each) { get path }

      it 'returns a 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the user is logged in' do
      before(:each) do
        login_as(user)
        get path
      end

      it 'returns a 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user object' do
        expect(response.body).to include('user')
      end
    end
  end
end
