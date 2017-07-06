class PasswordResetsController < ApplicationController
  before_action :find_user, :valid_user, :check_expiration,
    only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".email_info"
      redirect_to root_url
    else
      flash.now[:danger] = t ".email_error"
      render :new
    end
  end

  def edit; end

  def update
    user = @user
    if params[:user][:password].empty?
      user.errors.add :password, t(".cant_empty")
      render :edit
    elsif user.update_attributes user_params
      log_in user
      user.update_attributes reset_digest: nil
      flash[:success] = t ".success_reset"
      redirect_to user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def find_user
    @user =
      if params[:email]
        User.find_by email: params[:email]
      else
        User.find_by email: params[:user][:email]
      end

    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end

  def valid_user
    return if @user && @user.activated? && @user.authenticated?(:reset, params[:id])
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t ".expire"
    redirect_to new_password_reset_url
  end
end
