require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'should create a like correctly' do
    user = User.create(name: 'Leon', email: 'leon@example.com', password: '123456')
    first_post = Post.create(content: 'Bonnie and Clyde, a legendary criminal couple', user: user)
    expect(Like.create(user: user, post: first_post)).to be_valid
    
  end
end
