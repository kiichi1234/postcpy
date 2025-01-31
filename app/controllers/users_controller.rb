class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit block update destroy blocked_user )
  before_action :logged_in_user, only: %i(index show edit update destroy)
  before_action :admin_user, only: %i(index destroy )
  before_action :correct_user, only: %i(edit update show)
  before_action :not_current, only: %i(block)

  def index
    @users = User.where.not(admin: true).order(created_at: :desc)
  end

  def show
    @posts = Post.where(user_id: current_user.id).order("created_at DESC")
  end

  def new
    if logged_in? && !current_user.admin?
      flash[:info] = "すでにログインしています。"
      redirect_to current_user
    end

    @user = User.new
    Rails.logger.info "成功です。"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザーの新規作成に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end

  def block
    @block = Block.new
    @blocked_exists = Block.exists?(blocker_id: current_user.id, blocked_id: @user.id)
    
  end

  def blocked_user
    @block = Block.where(blocker_id: current_user.id).pluck(:blocked_id)
    @blocked = User.where(id: @block)
    
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :viewer)
  end

  def set_user #どのユーザーかを調べる。user_idを取り出す。
    @user = User.find(params[:id])
  end
end
