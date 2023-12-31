require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  include AuthHelper

  describe 'POST /create' do
    let(:path) { '/api/v1/comments' }
    let!(:user) { FactoryBot.create(:user) }
    let!(:blog_post) { FactoryBot.create(:post) }
    let!(:params) { { comment: { body: 'Hello, world!', post_id: blog_post.id } } }

    context 'when the user is not logged in' do
      it 'returns a 401' do
        post path, params: params
        expect(response).to have_http_status(401)
      end
    end

    context 'when the user is logged in' do
      it 'returns a 200' do
        login_as user
        post path, params: params
        expect(response).to have_http_status(:ok)
      end

      it 'returns the comment' do
        login_as user
        post path, params: params
        expect(response.body).to include('Hello, world!')
      end
    end

    context 'when the comment is invalid' do
      it 'returns a 422' do
        login_as user
        post path, params: { comment: { body: '', post_id: blog_post.id } }
        expect(response).to have_http_status(422)
      end
    end
  end
end
