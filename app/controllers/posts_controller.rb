class PostsController < ApplicationController
   
   def new
        @post = Post.new
   end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        
        if @post.save!
            flash[:notice] = "投稿しました。"
            Rails.logger.info "成功です。"
        
        else
            render :new
            flash[:alert] = "投稿失敗しました。"
            Rails.logger.info "失敗です。"
            
        end
    end
    
    private
    
    def post_params
        params.require(:post).permit(:category, :body)
        
    end
    
    
end
