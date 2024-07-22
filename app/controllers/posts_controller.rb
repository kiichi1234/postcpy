class PostsController < ApplicationController
   
   def new
        @post = Post.new
   end
    
    def create
        @post = Post.new(post_params)
        
        if @post.save
            flash[:notice] = "投稿しました。"
            Rails.logger.info "成功です。"
        
        else
            flash[:alert] = "投稿失敗しました。"
            
        end
    end
    
    private
    
    def post_params
        params.require(:post).permit(:category, :body)
        
    end
    
    
end
