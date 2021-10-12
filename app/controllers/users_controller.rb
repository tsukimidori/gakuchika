class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @quests = Quest.where(user_id: params[:id])
    @joins = Join.where(user_id: params[:id])
  end
end
