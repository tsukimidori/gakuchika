class CreateQuests < ActiveRecord::Migration[6.0]
  def change
    create_table :quests do |t|
      t.string :title,                null: false
      t.string :reward
      t.date :date,                   null: false
      t.string :target,               null: false
      t.string :point
      t.text :detail
      t.integer :place_id,            null: false
      t.integer :target_attribute_id, null: false
      t.timestamps
    end
  end
end
