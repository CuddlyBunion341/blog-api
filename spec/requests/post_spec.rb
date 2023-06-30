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
end
