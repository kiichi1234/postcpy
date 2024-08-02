class PostsController < ApplicationController
   
   def new
        @post = Post.new
   end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        
        if @post.save
            flash[:notice] = "投稿しました。"
            
        
        else
            render :new
            flash[:alert] = "投稿失敗しました。"
            
            
        end
    end
    
    def destroy
        post = Post.find(params[:id])
        
        if post.user_id == current_user.id
            post.destroy!
            Rails.logger.info "成功です。"
            redirect_to user_path(current_user)
        end
    end
    
    private
    
    def post_params
        params.require(:post).permit(:category, :body)
        
    end
    
    
end
