class BlocksController < ApplicationController
  def create
    @user = User.find(params[:id])
    @block = Block.create!(blocker_id: current_user.id, blocked_id: @user.id)
    Rails.logger.info @block
    redirect_to block_user_path(@user.id), notice: "ブロックしました。"
  end

  def destroy
    user = User.find(params[:id])
    block = Block.find_by(blocker_id: current_user.id, blocked_id: user.id)
    Block.where(blocker_id: current_user.id, blocked_id: user.id).exists?
    block.destroy!
    redirect_to block_user_path(@user.id), notice: "ブロック解除しました。"
  end
end
