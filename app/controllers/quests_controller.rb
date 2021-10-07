class QuestsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def new
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)
    if @quest.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :reward, :date, :target, :point, :detail, :place_id, :target_attribute_id, :image).merge(user_id: current_user.id)
  end

end
