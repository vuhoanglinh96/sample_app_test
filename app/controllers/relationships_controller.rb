class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    follow_type = params[:follow_type]
    @title = t ".#{follow_type}"
    @user = User.find_by id: params[:id]
    @users = @user.send(follow_type).paginate page: params[:page]
    render "users/show_follow"
  end

  def create
    @user = User.find_by id: params[:relationship][:followed_id]
    current_user.follow @user
    @unfollow = current_user.active_relationships.find_by followed_id: @user.id
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    @follow = current_user.active_relationships.build
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
