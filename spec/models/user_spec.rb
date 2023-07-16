require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should have a factory' do
      @user = FactoryBot.build(:user)

      expect(@user).to be_valid
    end

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(FactoryBot.create(:user)).to be_valid
    end
  end
end
