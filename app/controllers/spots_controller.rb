class SpotsController < ApplicationController
  
  def new
    @spot = Spot.new
  end
  
  def create
    spot = Spot.new(spot_params)
    spot.save
    redirect_to maps_path
  end
  
  
  private
  
  def spot_params
    params.require(:spot).permit(:title,:info,:image)
  end
  
end
