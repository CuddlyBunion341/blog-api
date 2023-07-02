require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    let(:path) { '/api/posts' }
    let!(:posts) { FactoryBot.create_list(:post, 10) }

    before { get path }

    it 'returns a list of posts' do
      expect(response).to have_http_status(200)
      expect(response.body).to eq(posts.to_json)
    end
  end

  describe 'GET /show' do
    let(:path) { "/api/posts/#{post_id}" }
    let(:post_id) { post.id }
    let!(:post) { FactoryBot.create(:post) }

    before { get path }

    it 'returns a specific post' do
      expect(response).to have_http_status(200)
      expect(response.body).to eq(post.to_json)
    end

    context 'when the post does not exist' do
      let(:post_id) { 0 }

      it 'returns a 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /random' do
    let(:path) { '/api/posts/random' }
    let!(:post) { FactoryBot.create(:post) }

    before { get path }

    it 'returns a random post' do
      expect(response).to have_http_status(200)
      expect(response.body).to eq(post.to_json)
    end

    context 'when there are no posts' do
      # TODO: fix this test

      let!(:post) { nil }

      it 'returns a 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /create' do
    let(:path) { '/api/posts' }
    let(:params) { { post: { title: 'Hello', content: 'World' } } }

    it 'returns a 201' do
      post path, params: params
      expect(response).to have_http_status(201)
    end

    it 'creates a new post' do
      expect { post path, params: params }.to change(Post, :count).by(1)
    end

    context 'when the post is invalid' do
      let(:params) { { post: { title: 'Hello' } } }

      it 'returns a 420' do
        post path, params: params
        expect(response).to have_http_status(420)
      end
    end
  end
end
