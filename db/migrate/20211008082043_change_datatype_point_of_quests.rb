class ChangeDatatypePointOfQuests < ActiveRecord::Migration[6.0]
  def change
    change_column :quests, :point, :text
  end
end