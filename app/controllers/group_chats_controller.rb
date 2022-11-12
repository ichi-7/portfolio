class GroupChatsController < ApplicationController
  
  def show
    @chats = GroupChat.where(plan_id: params[:plan_id]).order(id: "DESC").page(params[:page]).per(10)
  end
  
  def create
    @chat = GroupChat.new(chat_params)
    @chat.save
    redirect_to plan_group_chats_path(params[:plan_id])
  end
  
  def destroy
    
  end
  
  
  private
  
  def chat_params
    params.require(:group_chat).permit(:user_id,:plan_id,:message)
  end
  
end
