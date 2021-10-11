class Quest < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :place, :shortcuts => [:name]
  belongs_to :target_attribute, :shortcuts => [:name]
  belongs_to :user
  has_one_attached :image
  has_many :applies
  has_many :joins

  validates :title,               presence: true
  validates :date,                presence: true
  validates :target,              presence: true
  validates :place_id,            presence: true
  validates :target_attribute_id, presence: true
  validates :capacity,            presence: true
end
