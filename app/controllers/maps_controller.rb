class MapsController < ApplicationController
  
  def index
    @spots = Spot.all
    gon.spots = Spot.all
  end
  
end
