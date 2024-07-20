class PostsController < ApplicationController
   
   def new
        @post = post.new
   end
    
    def create
        @post = post.new([:post])
        
        if @post.save
            flash[:notice] = "投稿しました。"
        
        else
            flash[:alert] = "投稿失敗しました。"
            
        end
    end
    
    private
    
    def post_params
        params.require(:post).permit(:category, :body)
        
    end
    
    
end
