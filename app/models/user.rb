class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships # sent requests
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id' # received requests

  has_many :pending_friendships, -> {where (confirmed: false)}, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :accepted_friendships_thru_pending_friendships, -> {where (confirmed: true)}, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :accepted_friends_thru_pending_friendships, through: :accepted_friendships_thru_pending_friendships, source: :user

  has_many :inverse_friendships, -> {where (confirmed: false)}, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :accepted_friendships_thru_inverse_friendships, -> {where (confirmed: true)}, class_name: 'Friendship',  
  foreign_key: 'user_id'
  has_many :accepted_friends_thru_inverse_friendships, through: :accepted_friendships_thru_inverse_friendships, source: :friend
  
  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def friend?(user)
    friends.include?(user)
  end
end
