require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    let(:path) { '/api/v1/posts' }
    let!(:posts) { FactoryBot.create_list(:post, 10) }

    before { get path }

    it 'returns a list of posts' do
      expect(response).to have_http_status(200)
      # TODO: test that the response body is the list of posts
    end
  end

  describe 'GET /show' do
    let(:post_id) { post.id }
    let(:path) { "/api/v1/posts/#{post_id}" }
    let!(:post) { FactoryBot.create(:post) }
    let!(:comments) { FactoryBot.create_list(:comment, 8, post: post) }

    before { get path }

    it 'returns a specific post' do
      expect(response).to have_http_status(200)
      # TODO: test that the response body is the post
    end

    context 'when the post does not exist' do
      let(:post_id) { 0 }

      it 'returns a 404' do
        expect(response).to have_http_status(404)
      end
    end

    it 'returns a list of comments for the post' do
      get "#{path}?expand=comments"

      # TODO: test that the response body is the list of comments

      expect(response.body).to include('comments')

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /random' do
    let(:path) { '/api/v1/posts/random' }
    let!(:post) { FactoryBot.create(:post) }

    before { get path }

    it 'returns a random post' do
      expect(response).to have_http_status(200)
      # TODO: test that the response body is a random post
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
    let(:path) { '/api/v1/posts' }
    let!(:params) { { post: { title: 'Hello', content: 'World', user: FactoryBot.create(:user) } } }

    it 'returns a 201' do
      post path, params: params
      expect(response).to have_http_status(201)
    end

    it 'creates a new post' do
      expect { post path, params: params }.to change(Post, :count).by(1)
    end

    context 'when the post is invalid' do
      let(:params) { { post: { title: 'Hello' } } }

      it 'returns a 422' do
        post path, params: params
        expect(response).to have_http_status(422)
      end
    end
  end
end
