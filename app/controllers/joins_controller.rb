class JoinsController < ApplicationController

  def index
    @joins = Join.where(quest_id: params[:quest_id]).includes(:user)
  end

  def create
    @join = Join.create(quest_id: join_params[:quest_id], user_id: join_params[:user_id])
    Apply.find(join_params[:apply_id]).destroy!
    redirect_to quest_applies_path(@join.quest), notice: "#{@join.user.last_name}#{@join.user.first_name}さんを承認しました！"
  end

  def destroy
    @join = Join.find(params[:id])
    @join.destroy!
    @quest = Quest.find(params[:quest_id])
    redirect_to quest_path(@quest), notice: "#{@quest.title}への参加を取り消しました"
  end

  private
  def join_params
    params.permit(:quest_id, :user_id, :apply_id)
  end
end