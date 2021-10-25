class AppliesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :move_quest_show, only: [:index]

  def index
    @applies = Apply.where(quest_id: params[:quest_id]).includes(:user)
  end

  def create
    current_user.applies.create(quest_id: apply_params[:quest_id])
    redirect_to quest_path(apply_params[:quest_id]), notice: '応募申請しました'
  end

  def destroy
    @apply = Apply.find(params[:id])
    @apply.destroy!
    @quest = Quest.find(params[:quest_id])
    redirect_to quest_path(@quest), notice: '応募申請を取消しました'
  end

  private
  def apply_params
    params.permit(:quest_id)
  end

  def move_quest_show
    @quest = Quest.find(params[:quest_id])
    if current_user.id != @quest.user_id
      redirect_to quest_path(@quest)
    end
  end
end
