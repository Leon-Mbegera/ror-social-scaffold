require 'rails_helper'

RSpec.describe Friendship, type: :model do

  let(:user) { User.create(name: "Bonnie", email: "bonnie@example.com", password: "123456")}
  let(:friend) { User.create(name: "Clyde", email: "clyde@example.com", password: "123456")}
  let(:friendship) { Friendship.create(user: user, friend: friend)}

  it "should be created between user and friend" do
    expect(friendship.valid?).to be true
  end

  it "should have a default status of false" do
    expect(friendship.confirmed).to be nil
  end
end