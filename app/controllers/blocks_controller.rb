class BlocksController < ApplicationController
  def create
    @user = User.find(params[:id])
    @block = Block.create(blocker_id: current_user.id, blocked_id: @user)
    redirect_to block_user_path(current_user), notice: "ブロックしました。"
  end

  def destroy
    @user = User.find(params[:id])
    block = Block.find(blocker_id: current_user.id, blocked_id: @user)
    block.destroy!
    redirect_to block_user_path(current_user), notice: "ブロック解除しました。"
  end
end
