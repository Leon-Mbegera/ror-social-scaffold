require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:user) { User.create(name: "Leon", email: "leon@example.com", password: "123456")}
  let(:first_post) { Post.create(content: "Bonnie and Clyde, a legendary criminal couple", user: user)}
  let(:second_post) { Post.create(content: " ")}

  context "Post validity check" do

    it "should have valid attributes" do
      expect(first_post.valid?).to be true
    end

    it "ensures content attribute isn't blank" do
      expect(second_post.errors.full_messages).to include("Content can't be blank")
    end

    it "should be likable" do
      likable = first_post.likes.create(user: user)
      expect(likable.valid?).to be true
    end

    it "should be commentable" do
      commentable = first_post.comments.create(content: "One crazy couple, init?", user: user)
      expect(commentable.valid?).to be true
    end
  end
end