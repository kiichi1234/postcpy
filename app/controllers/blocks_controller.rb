class BlocksController < ApplicationController
  def create
    @user = User.find(params[:id])
    @block = Block.create!(blocker_id: current_user.id, blocked_id: @user.id) #保存に失敗するとエラーが起きる。作成 + 保存
    Rails.logger.info @block
    redirect_to block_user_path(@user.id), notice: "ブロックしました。"
  end

  def destroy
    user = User.find(params[:id])
    block = Block.find_by(blocker_id: current_user.id, blocked_id: user.id) #条件一致した最初のレコードを取り出す。 nullを返す
    block.destroy!
    redirect_to block_user_path(user.id), notice: "ブロック解除しました。"
  end
end
