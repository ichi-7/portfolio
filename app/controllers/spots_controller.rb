class SpotsController < ApplicationController
  
  def new
    @spot = Spot.new
    @post = Post.new
  end
  
  def create
    @spot = Spot.new(spot_params)
    if Spot.where(position: @spot.position).where(lat: @spot.lat).where(lng: @spot.lng).count == 0
      @spot.save
    end
    @post = Post.new(post_params[:post])
    @post.user_id = current_user.id
    @post.spot_id = Spot.find_by(position: @spot.position, lat: @spot.lat, lng: @spot.lng).id
    @post.save
    redirect_to posts_path
  end
  
  
  private
  
  def spot_params
    params.require(:spot).permit(:name,:position,:lat,:lng)
  end
  
  def post_params
    params.require(:spot).permit(post:[:title,:info,:image])
  end
  
end
