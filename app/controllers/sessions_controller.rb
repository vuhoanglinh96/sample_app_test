class SessionsController < ApplicationController
  before_action :find_user, only: [:create]

  def new; end

  def create
    if @user && @user.authenticate(params[:session][:password])
      login_activated_user @user
    else
      flash.now[:danger] = t ".password_error"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def find_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user
    flash.now[:danger] = t ".email_error"
    render :new
  end
end
