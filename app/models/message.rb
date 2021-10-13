class Message < ApplicationRecord
  belongs_to :user
  belongs_to :quest

  validates :message, presence: true
  validates :like, numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 1}, presence: true
  validates :sending_party_id, presence: true
end
