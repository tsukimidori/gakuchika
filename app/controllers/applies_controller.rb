class AppliesController < ApplicationController

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
end
