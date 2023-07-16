require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    it 'should have a factory' do
      @post = FactoryBot.build(:post)

      expect(@post).to be_valid
    end

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(FactoryBot.create(:post)).to be_valid
    end
  end
end
