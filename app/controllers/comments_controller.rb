class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    Rails.logger.info "成功です。"
    @comment = Comment.new(comment_params)
    Rails.logger.info "newも成功です。"
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @comment.save
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
