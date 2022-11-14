class GroupChatsController < ApplicationController
  
  def show
    @plan = Plan.find(params[:plan_id])
    # 参加していない企画のグループチャットに参加させない
    unless PlanMember.exists?(user_id: current_user.id, plan_id: @plan.id)
      redirect_to users_path
    end
    @chats = GroupChat.where(plan_id: params[:plan_id]).order(id: "DESC")
  end
  
  def create
    @chat = GroupChat.new
    @chat.user_id = current_user.id
    @chat.plan_id = params[:plan_id]
    @chat.message = params[:message]
    @chat.save
    redirect_to plan_group_chats_path(params[:plan_id])
  end
  
  def destroy
    chat = GroupChat.find(params[:id])
    chat.destroy
    redirect_to plan_group_chats_path(params[:plan_id])
  end
  
  
  private
  
  def chat_params
    params.require(:group_chat).permit(:message)
  end
  
end
