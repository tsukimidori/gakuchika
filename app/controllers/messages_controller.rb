class MessagesController < ApplicationController

  def create
    quest = Quest.find(params[:quest_id])
    message = quest.messages.build(message_params)
    message.user_id = current_user.id
    binding.pry
    if message.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def message_params
    params.require(:message).permit(:message, :like)
  end
end
