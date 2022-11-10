class PlansController < ApplicationController
  
  def index
    @plans = Plan.all
  end
  
  def show
    @plan = Plan.find(params[:id])
  end
  
  def create
    # プランを投稿・保存
    @plan = Plan.new(plan_params)
    @plan.save
    
    # 同ユーザーの直近の投稿IDを取得(Planテーブル)
    plans = Plan.all.order(id: "DESC")
    plan = plans.find_by(user_id: current_user.id)
    
    # 各データの配列化
    @places = place_params
    names = @places[:place][:name].split
    lats = @places[:place][:lat].split
    lngs = @places[:place][:lng].split
    
    # 配列の要素数を取得(経由地の数)
    cnt = names.count
    
    # 各データをplaceモデルに保存
    for i in 1..(cnt) do
      @place = Place.new
      @place.plan_id = plan.id
      @place.name = names[i - 1]
      @place.lat = lats[i - 1]
      @place.lng = lngs[i - 1]
      @place.save
    end
    
    # 完了画面に遷移
    redirect_to plans_complete_path
  end
  
  def route
    @plan = Plan.new
    @place = Place.new
    
  end
  
  def info
    @plan = Plan.new
  end
  
  def confirm
    # 保存用データを変数に入れる
    @plan = Plan.new
    @place = Place.new
    @start_day = params[:plan]['start_day(1i)'] + "年" + params[:plan]['start_day(2i)'] + "月" + params[:plan]['start_day(3i)'] + "日"
    @end_day = params[:plan]['end_day(1i)'] + "年" + params[:plan]['end_day(2i)'] + "月" + params[:plan]['end_day(3i)'] + "日"
    @meeting_place = params[:plan][:meeting_place]
    @meeting_time = params[:plan]['meeting_time(4i)'] + "：" + params[:plan]['meeting_time(5i)']
    @memo = params[:plan][:memo]
    
    # 経由地名を配列化してjs用の変数に入れる
    names = params[:plan][:spot_name]
    @spot_names = names.split(",")
    gon.spot_names = @spot_names
    
    # 緯度を配列化してjs用の変数に入れる
    lats = params[:plan][:spot_lat]
    @spot_lats = lats.split(",")
    gon.spot_lats = @spot_lats
    
    # 経度を配列化してjs用の変数に入れる
    lngs = params[:plan][:spot_lng]
    @spot_lngs = lngs.split(",")
    gon.spot_lngs = @spot_lngs
  end
  
  def complete
    # 同ユーザーの直近の投稿IDを取得(Planテーブル)
    plans = Plan.all.order(id: "DESC")
    plan = plans.find_by(user_id: current_user.id)
    @id = plan.id
  end
  
  
  private
  
  def plan_params
    params.require(:plan).permit(:user_id,:plan_name,:start_day,:end_day,:meeting_place,:meeting_time,:memo)
  end
  
  def place_params
    params.require(:plan).permit(place:[:name,:lat,:lng])
  end
  
end
