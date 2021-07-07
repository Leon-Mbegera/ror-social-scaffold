class FriendshipsController < ApplicationController

  def index
    @friendships = Friendship.all
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.pending_friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to users_path, notice: "Request sent!"
    else
      redirect_to users_path, notice: "Request failed!"
  end

  def destroy
    Friendship.find_by(id: params[:id]).destroy
    redirect_to root_path
  end

  def update
    Friendship.find_by(id: params[:id]).update_attribute(:confirmed, true)
    redirect_to root_path
  end
end
