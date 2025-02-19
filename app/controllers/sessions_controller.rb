class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to new_post_path
    end
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user) #永続的なログイン
      Rails.logger.info "成功です。"
      redirect_to new_post_path
    else
      Rails.logger.info "失敗です。"
      flash.now[:danger] = "認証に失敗しました。"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
