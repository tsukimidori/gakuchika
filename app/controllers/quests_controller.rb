class QuestsController < ApplicationController
  before_action :set_quest, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :move_quest_show, only: [:edit, :update, :destroy]

  def index
    @quest = Quest.includes(:user).order(id: "DESC").page(params[:page]).without_count.per(6)
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

  def show
    @apply = Apply.find_by(quest_id: @quest.id)
    @join = Join.find_by(quest_id: @quest.id)
    @joins = Join.where(quest_id: @quest.id)
    @messages = @quest.messages
    @message = Message.new
  end

  def edit
  end

  def update
    if @quest.update(quest_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @quest.destroy
    redirect_to root_path
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(:title, :reward, :date, :target, :point, :detail, :place_id, :target_attribute_id, :capacity, :image).merge(user_id: current_user.id)
  end

  def move_quest_show
    if current_user.id != @quest.user_id || Join.exists?(quest_id: @quest.id)
      redirect_to quest_path(@quest)
    end
  end

end
