class SpotsController < ApplicationController
  
  def show
    @spot_name = Spot.find(params[:id]).name
    @posts = Post.where(spot_id: params[:id]).order(id: "DESC").page(params[:page]).per(8)
  end
  
  def new
    @spot = Spot.new
    @post = Post.new
  end
  
  def create
    if params[:spot][:position] == "" then
      redirect_to request.referer, alert: '※ スポットが指定されていません'
    else
      @spot = Spot.new(spot_params)
      # スポット情報がまだない場合は新規登録
      if Spot.where(position: @spot.position).count == 0 then
        @spot.save
      end
      # 投稿情報を保存
      @post = Post.new(post_params[:post])
      @post.user_id = current_user.id
      @post.spot_id = Spot.find_by(position: @spot.position).id
      @post.save
      # 投稿後に記事ページに移動
      posts = Post.all.order(id: "DESC")
      pos = posts.find_by(user_id: current_user.id)
      redirect_to post_path(pos.id)
    end
  end
  
  
  private
  
  def spot_params
    params.require(:spot).permit(:name,:position,:lat,:lng)
  end
  
  def post_params
    params.require(:spot).permit(post:[:title,:info,:image])
  end
  
end
