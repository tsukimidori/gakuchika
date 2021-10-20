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

  with_options format: { with: /\A[0-9]+\z/, message: "は半角数字で入力してください"} do
    validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10, message: "が人数制限の範囲外または数字以外で入力されています"}
  end
end
