require 'rails_helper'

RSpec.describe 'Users::Registrations', type: :request do
  describe 'POST /create' do
    let(:path) { '/api/v1/signup' }
    let(:params) { { user: { username: 'testUser', email: 'test@example.com', password: 'password' } } }
    let(:bad_params) { { user: {} } }

    context 'when params are valid' do
      before(:each) do
        post path, params: params
      end

      it 'returns a 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user' do
        expect(JSON.parse(response.body)['user']['username']).to eq('testUser')
      end
    end

    context 'when params are invalid' do
      before(:each) do
        post path, params: bad_params
      end

      it 'returns a 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to include('Username can\'t be blank')
      end
    end
  end
end
