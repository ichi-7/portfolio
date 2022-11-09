class PlansController < ApplicationController
  
  def index
  end
  
  def show
  end
  
  def create
    
  end
  
  def route
    @plan = Plan.new
  end
  
  def info
    @plan = Plan.new
  end
  
  def confirm
    @plan = Plan.new
    @start_day = params[:plan]['start_day(1i)'] + "年" + params[:plan]['start_day(2i)'] + "月" + params[:plan]['start_day(3i)'] + "日"
    @end_day = params[:plan]['end_day(1i)'] + "年" + params[:plan]['end_day(2i)'] + "月" + params[:plan]['end_day(3i)'] + "日"
    @meeting_place = params[:plan][:meeting_place]
    @meeting_time = params[:plan]['meeting_time(4i)'] + "：" + params[:plan]['meeting_time(5i)']
    @memo = params[:plan][:memo]
    
    names = params[:plan][:spot_name]
    @spot_names = names.split(",")
    gon.spot_names = @spot_names
    
    lats = params[:plan][:spot_lat]
    @spot_lats = lats.split(",")
    gon.spot_lats = @spot_lats
    
    lngs = params[:plan][:spot_lng]
    @spot_lngs = lngs.split(",")
    gon.spot_lngs = @spot_lngs
  end
  
end
