class PlacesController < ApplicationController
  
  def index
    @place = Place.all
    gon.place = @place
  end
  
  
  private
  
  def place_params
    params.require(:place).permit(:address)
  end
  
end
