class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def requests_not_confirmed
    @pending_friends = current_user.pending_friends
    @inverse_friends = current_user.inverse_friends
    @pending_friendships = current_user.pending_friendships
    @inverse_friendships = current_user.inverse_friendships
  end

  def friends
    @friends = current_user.friends
  end
end
