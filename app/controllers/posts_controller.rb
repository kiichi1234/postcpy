#controller:viewでデータを表示するためにモデルから必要なデータを取得
class PostsController < ApplicationController
  before_action :set_post, only: %i(edit update)
  before_action :correct_user, only: %i(edit update)
  before_action :edit, only: %i(update)
  
  def index 
    @block = Block.where(blocker_id: current_user.id).pluck(:blocked_id) #現在ログインしているユーザーのブロックユーザーを取得。
    @posts = Post.where.not(user_id: @block) #blockをpostの条件を入れることでブロックユーザー投稿非表示
    @category = params.dig(:search, :category)
    @word = params.dig(:search, :word)
    @posts = @posts.where(category: @category) if @category.present?
    @posts = @posts.where("body LIKE ?", "%#{@word}%") if @word.present?
  end

  def show
    @block = Block.where(blocker_id: current_user.id).pluck(:blocked_id)
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.where.not(user_id: @block)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if current_user.viewer?
      raise "閲覧ユーザーのため投稿出来ません。" #エラーハンドリング
    elsif @post.save
      redirect_to user_path(current_user), notice: "投稿が成功しました。"
    else
      raise "保存に失敗しました。"
    end
  rescue => e
    flash[:alert] = e.message
    render :new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    if @post.user_id == current_user.id
      @post.update(post_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if current_user.admin?
      post.destroy!
      redirect_to posts_path(current_user)
    elsif post.user_id == current_user.id
      post.destroy!
      redirect_to user_path(current_user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:category, :body)
  end

  def post_search_params
    params.fetch(:search, {}).permit(:category, :word)
  end
  def set_post
    @post = Post.find(params[:id])
    @user = @post.user
  end
end
