require 'rails_helper'

RSpec.describe 'Users::Sessions', type: :request do
  describe 'GET /user' do
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

  describe 'POST /login' do
    let(:path) { '/api/v1/login' }
    let(:params) { { email: user.email, password: 'password' } }
    let(:invalid_params) { { email: user.email, password: 'wrong_password' } }
    let!(:user) { FactoryBot.create(:user, password: 'password') }

    context 'when params are valid' do
      before(:each) do
        post path, params: params
      end

      it 'returns a 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user' do
        expect(JSON.parse(response.body)['user']['id']).to eq(user.id)
      end
    end

    context 'when params are invalid' do
      before(:each) do
        post path, params: invalid_params
      end

      it 'returns a 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('Invalid email or password')
      end
    end
  end

  describe 'DELETE /logout' do
    let(:path) { '/api/v1/logout' }
    let!(:user) { FactoryBot.create(:user) }

    context 'when user is not logged in' do
      it 'returns 401' do
        delete path
        expect(response).to have_http_status(401)
      end
    end

    context 'when user is logged in' do
      it 'returns 200' do
        sign_in_as(user)
        delete path
        expect(response).to have_http_status(200)
      end
    end
  end
end
