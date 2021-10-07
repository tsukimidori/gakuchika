class Quest < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :title,               presence: true
  validates :date,                presence: true
  validates :target,              presence: true
  validates :place_id,            presence: true
  validates :target_attribute_id, presence: true


  belongs_to :place
  belongs_to :target_attribute
end
