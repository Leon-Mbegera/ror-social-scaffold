require 'rails_helper'

RSpec.describe User, type: :model do
  context 'User validity' do
    it 'should have valid attributes' do
      first_user = User.create(name: 'Bonnie', email: 'bonnie@example.com', password: '123456')
      expect(first_user.valid?).to be true
    end

    it 'should have ALL defined attributes' do
      second_user = User.create(name: 'Clyde', password: '123456')
      expect(second_user.valid?).to be false
    end

    it 'should not have any nil attribute values' do
      third_user = User.create(name: 'Clyde', email: 'clyde@example.com', password: ' ')
      expect(third_user.errors.full_messages).to include("Password can't be blank")
    end
  end

  context 'user associations' do
    it 'can have many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eq(:has_many)
    end

    it 'can have many friendships' do
      user = User.reflect_on_association(:friendships)
      expect(user.macro).to eq(:has_many)
    end

    it 'can have many comment' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eq(:has_many)
    end

    it 'can have many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eq(:has_many)
    end
  end
end
