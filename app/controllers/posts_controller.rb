class PostsController < ApplicationController
  
  def index
    @posts = Post.all.order(id: "DESC").page(params[:page]).per(8)
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
    # 本人でないと編集ページに行けない
    if @post.user_id == current_user.id
      render "edit"
    else
      redirect_to posts_path
    end
  end
  
  def update
    pos = Post.find(params[:id])
    pos.update(post_params)
    redirect_to post_path(pos.id)  
  end
  
  def destroy
    pos = Post.find(params[:id])
    pos.destroy
    redirect_to posts_path
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:title,:info,:image)
  end
  
end
