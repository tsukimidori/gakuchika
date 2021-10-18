class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @quests = Quest.where(user_id: params[:id])
    @joins = Join.where(user_id: params[:id])
    @score = Message.group(:sending_party_id).having(sending_party_id: params[:id]).sum(:like)
  end
end
