class PostsController < ApplicationController
   before_action :edit, only: %i(update)
   
   def index
        @category = params[:category]
        @posts = Post.order(created_at: :desc)
   end
   
   def show
        @post = Post.find(params[:id])
        @comment = Comment.new
        @comments = @post.comments.includes(:user).all
   end
   
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
    
    def edit
       @post = current_user.posts.find(params[:id])
    end
    
    def update
        if @post.user_id == current_user.id
            @post.update(post_params)
            redirect_to user_path(current_user)
        else
            render :edit
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
    
    def post_search_params
        params.fetch(:search, {}).permit(:category, :word)
    end
    
    
end
