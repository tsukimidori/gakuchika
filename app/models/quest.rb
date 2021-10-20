class Quest < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :place, :shortcuts => [:name]
  belongs_to :target_attribute, :shortcuts => [:name]
  belongs_to :user
  has_one_attached :image
  has_many :applies
  has_many :joins
  has_many :messages

  validates :title,               presence: true
  validates :date,                presence: true
  validates :target,              presence: true
  validates :place_id,            presence: true, numericality: { message: "を選択してください" }
  validates :target_attribute_id, presence: true, numericality: { message: "を選択してください" }
  validates :capacity,            presence: true
end
