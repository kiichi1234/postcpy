class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
  
    if current_user.viewer?
      raise "閲覧ユーザーのため返信出来ません。"
    elsif @comment.save
      redirect_to post_path(current_user), notice: "返信が成功しました。"
    else
      raise "保存に失敗しました。"
    end
    
  rescue => e
    flash[:alert] = e.message
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
