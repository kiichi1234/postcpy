class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:id])
        @commment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @comment.post_id = @post.id
        @comment.save
        debugger
        Rails.logger.info "成功です。"
        redirect_to posts_url
    end
    
    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
