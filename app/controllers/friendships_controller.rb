class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.all
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.build(friendship_params)
    if @friendship.save
      redirect_to root_path, notice: 'Request sent!'
    else
      redirect_to root_path, notice: 'Request failed!'
    end
  end

  def destroy
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.destroy
    redirect_to root_path
  end

  def update
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.confirm_friend
    @friendship.save
    redirect_to friends_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id, :confirmed)
  end
end
