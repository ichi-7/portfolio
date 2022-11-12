class PlansController < ApplicationController
  
  def index
    @plans = Plan.all.order(id: "DESC").page(params[:page]).per(8)
  end
  
  def show
    @plan = Plan.find(params[:id])
    
    @start_day = @plan.start_day
    @end_day = @plan.end_day
    @meeting_place = @plan.meeting_place
    @meeting_time = @plan.meeting_time
    @memo = @plan.memo
    
    @places = Place.where(plan_id: @plan.id)
    
    # 経由地名を配列化してjs用の変数に入れる
    @names = @places.pluck(:name)
    gon.spot_names = @names
    
    # 緯度を配列化してjs用の変数に入れる
    @lats = @places.pluck(:lat)
    gon.spot_lats = @lats
    
    # 経度を配列化してjs用の変数に入れる
    @lngs = @places.pluck(:lng)
    gon.spot_lngs = @lngs
    
    @members = PlanMember.where(plan_id: @plan.id)
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
  
  def edit
    @plan = Plan.find(params[:id])
  end
  
  def update
    plan = Plan.find(params[:id])
    plan.update(plan_params)
    redirect_to plan_path(plan.id)  
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
    @start_day = params[:plan]['start_day(1i)'] + "-" + params[:plan]['start_day(2i)'] + "-" + params[:plan]['start_day(3i)']
    @end_day = params[:plan]['end_day(1i)'] + "-" + params[:plan]['end_day(2i)'] + "-" + params[:plan]['end_day(3i)']
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
    plan_member = PlanMember.new(user_id: current_user.id, plan_id: @id)
    plan_member.save
  end
  
  def join
    @plan_member = PlanMember.new(user_id: current_user.id, plan_id: params[:plan_id])
    @plan_member.save
    redirect_to plan_path(params[:plan_id])
  end
  
  def out
    @plan_member = PlanMember.find_by(user_id: current_user.id, plan_id: params[:plan_id])
    @plan_member.destroy
    redirect_to plan_path(params[:plan_id])
  end
  
  
  private
  
  def plan_params
    params.require(:plan).permit(:user_id,:plan_name,:start_day,:end_day,:meeting_place,:meeting_time,:memo,:image)
  end
  
  def place_params
    params.require(:plan).permit(place:[:name,:lat,:lng])
  end
  
end
