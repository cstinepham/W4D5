require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create(username: "Bob", password: "password") }
  subject(:broken_user) { User.create(username: "Bob", password: "short") }

  describe 'tests all validations' do
    context 'valid user' do
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:password_digest) }
    end

    context 'invalid password' do
      it { should validate_length_of(:password).is_at_least(6) }
    end

    context 'user already exists' do
      subject(:user) { User.create(username: "Bob", password: "password") }
      it { should validate_uniqueness_of(:username) }
    end

    it 'ensures assignment of session token' do
      expect (user.session_token).not_to be_nil
    end
  end

  describe 'tests ::find_by_credentials' do
    it 'finds the user if exists' do
      user = User.find_by_credentials("Bob", "password")
      expect(user).not_to be_nil
      user2 = User.find_by_credentials("Jane", "eijnwr")
      expect(user2).to be_nil
    end
  end

  describe 'tests associations' do
    it { should have_many(:goals) }
    it { should have_many(:comments) }
  end

end
