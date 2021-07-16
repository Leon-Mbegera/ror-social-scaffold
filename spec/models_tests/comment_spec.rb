require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'check validity of comment' do
    it 'should have correct attributes' do
      user = User.create(name: 'Leon', email: 'leon@example.com', password: '123456')
      first_post = Post.create(content: 'Bonnie and Clyde, a legendary criminal couple', user: user)
      commentable = first_post.comments.create(content: 'One crazy couple, init?', user: user, post: first_post)
      expect(commentable.valid?).to be true
    end

    it 'should not have blank content' do
      user = User.create(name: 'Leon', email: 'leon@example.com', password: '123456')
      second_post = Post.create(content: 'They hailed from North Jersy, US', user: user)
      commentable = second_post.comments.create(content: '', user: user, post: second_post)
      expect(commentable.valid?).to be false
    end
  end
end
