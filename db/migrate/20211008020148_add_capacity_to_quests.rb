class AddCapacityToQuests < ActiveRecord::Migration[6.0]
  def change
    add_column :quests, :capacity, :integer, null: false
  end
end
